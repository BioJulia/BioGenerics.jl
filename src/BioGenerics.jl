# BioGenerics.jl
# ==============
#
# Core types and methods common to many packages in the BioJulia ecosystem.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioGenerics/blob/master/LICENSE.md

module BioGenerics
    
include("methods.jl")
include("Exceptions.jl")
include("IO.jl")
include("Testing.jl")

using .IO: readertype, writertype, @rdr_str, @wtr_str

end # module BioGenerics
