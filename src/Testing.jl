# Testing
# =======
#
# Utilities to assist testing of BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module Testing

"""
    random_array(n::Integer, elements, probs)
    
Create a random array of length `n`, composed of possible `elements`, which are
selected according to their `prob`.
"""
function random_array(n::Integer, elements, probs)
    @assert sum(probs) == 1.0 "the probabilities in probs, don't sum to 1.0!"
    cumprobs = cumsum(probs)
    x = Vector{eltype(elements)}(undef, n)
    for i in 1:n
        x[i] = elements[searchsorted(cumprobs, rand()).start]
    end
    return x
end

"""
    random_seq(n::Integer, nts, probs)

Create a random sequence of length `n`, composed of `nts`, according to their
`prob`.
"""
function random_seq(n::Integer, nts, probs)
    return String(random_array(n, nts, probs))
end

"""
    random_dna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])

Create a random DNA sequence of length `n`, by sampling the nucleotides
A, C, G, T, and N, according to their probability in `probs`. 
"""
function random_dna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])
    return random_seq(n, ['A', 'C', 'G', 'T', 'N'], probs)
end

"""
    random_rna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])

Create a random RNA sequence of length `n`, by sampling the nucleotides
A, C, G, U, and N, according to their probability in `probs`. 
"""
function random_rna(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])
    return random_seq(n, ['A', 'C', 'G', 'U', 'N'], probs)
end

"""
    random_aa(n, probs = [0.24, 0.24, 0.24, 0.24, 0.04])

Create a random amino acid sequence of length `n`, by sampling the possible
amino acid characters.
"""
function random_aa(len)
    return random_seq(len,
        ['A', 'R', 'N', 'D', 'C', 'Q', 'E', 'G', 'H', 'I',
         'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V', 'X' ],
        push!(fill(0.049, 20), 0.02))
end

"""
    intempdir(fn::Function, parent = tempdir())
    
Execute some function `fn` in a temporary directory.
After the function is executed, the directory is cleaned by doing the
equivalent of `rm -r`.
"""
function intempdir(fn::Function, parent = tempdir())
    dirname = mktempdir(parent)
    try
        cd(fn, dirname)
    finally
        rm(dirname, recursive = true)
    end
end

"""
    random_interval(minstart, maxstop)

Create a random interval between a minimum starting point, and a maximum stop
point.
"""
function random_interval(minstart, maxstop)
    start = rand(minstart:maxstop)
    return start:rand(start:maxstop)
end

end # Module Testing
