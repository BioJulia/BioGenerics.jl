using Documenter, BioGenerics

makedocs(
    format = Documenter.HTML(),
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
    repo = "github.com/BioJulia/BioGenerics",
    deps = nothing,
    make = nothing
)
