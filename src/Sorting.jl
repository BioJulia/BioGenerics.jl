module Sorting

"""
    alphanum(a::AbstractString, b::AbstractString)

Given strings of mixed characters and numbers, sort the numeric characters in value order, while sorting the non-numeric characters in ASCII order.
The end result is a natural sorting order.
"""
function alphanum(a::AbstractString, b::AbstractString)

    # Local isless definitions.
    isless(::Int, ::AbstractString) = true
    isless(::AbstractString, ::Int) = false
    isless(a, b) = Base.isless(a, b)

    # Split string into into substrings and integers.
    function alphanumchunks(str::AbstractString)

        matches = findall(r"(\d+|\D+)", str)

        chunks = map(matches) do m
            s = str[m]
            match(r"\d", s) != nothing ? parse(Int, s) : s
        end

        return chunks
    end

    # Split strings into chunks.
    a_chunks = alphanumchunks(a)
    b_chunks = alphanumchunks(b)

    # Compare the first n chunks.
    for (a_chunk, b_chunk) in zip(a_chunks, b_chunks)
        if !isequal(a_chunk, b_chunk)
            return isless(a_chunk, b_chunk)
        end
    end

    # The first n chunks were the same, the shorter vector is the lesser of the two.
    return length(a_chunks) < length(b_chunks)

end

end
