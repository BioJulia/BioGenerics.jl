# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Add option to do `T(f, ::IO)` where `{T <: AbstractFormattedIO}`. This allows a user to do e.g.
```julia
record = FASTA.Reader(GzipDecompressorStream(open(path))) do reader
    first(iterate(reader))
end
```

## [1.0.0] - 2019-02-08
### Added
- IO module.
- Automa module.
- Exceptions module.
- Testing module.
- Add numerous generic methods.

[Unreleased]: https://github.com/BioJulia/BioGenerics/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/BioJulia/BioGenerics/tree/v1.0.0
