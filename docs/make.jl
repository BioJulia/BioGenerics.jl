using Documenter, BioGenerics

makedocs(;
    modules=[BioGenerics],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/BioJulia/BioGenerics.jl/blob/{commit}{path}#L{line}",
    sitename="BioGenerics.jl",
    authors="Ben J. Ward",
    assets=[],
)

deploydocs(;
    repo="github.com/BioJulia/BioGenerics.jl",
)
