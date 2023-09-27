# BioGenerics.IO
# ==============
#
# I/O interfaces for BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module IO

# IO Types
# ---------

"Abstract formatted input/output type."
abstract type AbstractFormattedIO end

function (::Type{T})(f::Function, io::Base.IO, args...; kwargs...) where {T <: AbstractFormattedIO}
    fmt = T(io, args...; kwargs...)
    try
        f(fmt)
    finally
        close(fmt)
    end
end

"""
    stream(io::AbstractFormattedIO)

Return the underlying `IO` object; subtypes of `AbstractFormattedIO` must
implement this method.
"""
function stream end

# delegate method call
for f in (:eof, :flush, :close)
    @eval function Base.$(f)(io::AbstractFormattedIO)
        return $(f)(stream(io))
    end
end

"""
Abstract data reader type.

See `subtypes(AbstractReader)` for all available data readers.
"""
abstract type AbstractReader <: AbstractFormattedIO end

Base.IteratorSize(::Type{T}) where T <: AbstractReader = Base.SizeUnknown()

function Base.open(::Type{T}, filepath::AbstractString, args...; kwargs...) where T <: AbstractReader
    return T(open(filepath), args...; kwargs...)
end

function Base.open(f::Function, ::Type{T}, args...; kwargs...) where T <: AbstractFormattedIO
    io = open(T, args...; kwargs...)
    try
        f(io)
    finally
        close(io)
    end
end

function Base.read(input::AbstractReader)
    return read!(input, eltype(input)())
end

"""
    tryread!(reader::AbstractReader, output)

Try to read the next element into `output` from `reader`.

If the result could not be read, then `nothing` will be returned instead.
"""
function tryread!(reader::AbstractReader, output)
    try
        read!(reader, output)
        return output
    catch ex
        if isa(ex, EOFError)
            return nothing
        end
        rethrow()
    end
end

function Base.iterate(reader::AbstractReader, nextone = eltype(reader)())
    if tryread!(reader, nextone) === nothing
        return nothing
    else
        return copy(nextone), nextone
    end
end


"""
Abstract data writer type.

See `subtypes(AbstractWriter)` for all available data writers.
"""
abstract type AbstractWriter <: AbstractFormattedIO end

function Base.open(::Type{T}, filepath::AbstractString, args...; kwargs_...) where T <: AbstractWriter
    # Special case to improve inference by avoiding the kwarg stuff
    if isempty(kwargs_)
        return T(open(filepath, "w"), args...)
    end
    kwargs::Vector{<:Pair{Symbol}} = collect(kwargs_)
    i = findfirst(kwarg -> kwarg[1] == :append, kwargs)
    if i !== nothing
        append = kwargs[i][2]
        if !isa(append, Bool)
            throw(ArgumentError("append must be boolean"))
        end
        deleteat!(kwargs, i)
    else
        append = false
    end
    return T(open(filepath, append ? "a" : "w"), args...; kwargs...)
end

# We have this un-extendable function here because we expect
# to not be able to control compression-related code, whereas we might be able to get
# PRs to biological readers
# That's also why we return code here instead of objects - BioGenerics does not need
# to know what GzipDecompressorStream is, so we just return a symbol that could be anything,
# and let the module that used the macro resolve it.
function de_compressor_code(ending::Union{String, SubString{String}}, read::Bool)
    # TODO: It would be nice to have a good specialized BGZIP implementation...
    if in(ending, ("gzip", "gz", "bgzip"))
        read ? quote GzipDecompressorStream end : quote GzipCompressorStream end
    elseif ending == "xz"
        read ? quote XzDecompressorStream end : quote XzCompressorStream end
    elseif ending == "zst"
        read ? quote ZstdDecompressorStream end : quote ZstdCompressorStream end
    else
        nothing
    end
end

"""
    readertype(::Val{S}, arg)::T

Determine the type of reader that opens extension named by `Symbol` `S`.
For example, `readertype(::Val{:fa}, arg) = FASTA.Reader`.
Should be extended by developers making new biological file format readers.

The extra argument `arg` can be passed like so `rdr"path.ext"arg`, and defaults
to the empty string. This can be used to pass an additional argument that is specific
to the person implementing the reader.
"""
readertype(@nospecialize(v::Val{S}), arg) where S = error("Unknown biological file extension: \"$(string(S))\"")

"""
    writertype(::Val{S}, arg)::T

Determine the type of reader that can write a file with an extension named by `Symbol` `S`.
For example, `writertype(::Val{:fa}, arg) = FASTA.Writer`.
Should be extended by developers making new biological file format writers.

The extra argument `arg` can be passed like so `wtr"path.ext"arg`, and defaults
to the empty string. This can be used to pass an additional argument that is specific
to the person implementing the writer.
"""
writertype(@nospecialize(v::Val{S}), arg) where S = error("Unknown biological file extension: \"$(string(S))\"")

# Like splitext, but removes the dot from the extension
function pure_ext(path::Union{String, SubString{String}})
    (path, ext) = splitext(path)
    ext = (!isempty(ext) && first(ext) == '.') ? ext[2:end] : ext
    String(path), String(ext)
end

function resolve_reader(path::Union{String, SubString{String}}, arg::String)
    code = quote open($(path); lock=false) end
    (path, ext) = pure_ext(path)
    while (wrapper = de_compressor_code(ext, true)) !== nothing 
        code = quote $(wrapper)($code) end
        (path, ext) = pure_ext(path)
    end
    quote $(readertype(Val(Symbol(ext)), arg))($code) end
end

function resolve_writer(path::Union{String, SubString{String}}, arg::String)
    code = quote open($(path), "w"; lock=false) end
    (path, ext) = pure_ext(path)
    while (wrapper = de_compressor_code(ext, false)) !== nothing 
        code = quote $(wrapper)($code) end
        (path, ext) = pure_ext(path)
    end
    quote $(writertype(Val(Symbol(ext)), arg))($code) end
end

macro rdr_str(path, arg)
    esc(resolve_reader(path, arg))
end

macro rdr_str(path)
    esc(resolve_reader(path, ""))
end

macro wtr_str(path, arg)
    esc(resolve_writer(path, arg))
end

macro wtr_str(path)
    esc(resolve_writer(path, ""))
end

"""
    Base.open(f, ios::Vararg{AbstractFormattedIO})

Execute `f(ios...)`, then `close` each io.
`close` is run even if `f(ios...)` throws an exception.

# Examples
```julia
julia> open(rdr"path/to/seqs.fna") do reader
           # do something with reader
       end
```
"""
function Base.open(f::Function, first::AbstractFormattedIO, rest::Vararg{AbstractFormattedIO})
    try
        f(first, rest...)
    finally
        for i in (first, rest...)
            close(i)
        end
    end
end

end  # module BioGenerics.IO
