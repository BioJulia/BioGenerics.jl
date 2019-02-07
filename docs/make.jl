using Documenter, BioGenerics

makedocs(
    format = :html,
    modules = [BioGenerics],
    doctest = false,
    strict = false,
    pages = [
        "Home" => "index.md"
    ],
    sitename = "BioGenerics",
    authors = "Ben J. Ward"
)

deploydocs(
    repo = "github.com/BioJulia/BioGenerics.jl",
    deps = nothing,
    make = nothing
)
