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
include("Automa.jl")
include("IO.jl")
#include("Mem.jl")
#include("ReaderHelper.jl")
#include("RecordHelper.jl")
include("Sorting.jl")
include("Testing.jl")

end # module BioGenerics
