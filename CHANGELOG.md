# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Add GitHub Actions CI workflow to test downstream compatibility with direct dependants.

## [0.1.5] - 2024-07-11
### Changed
- Bump `TranscodingStreams` compatibility to 0.11 (#19).

## [0.1.4] - 2023-10-14
### Changed
- Bump `TranscodingStreams` compatibility to 0.10 (#16).

## [0.1.3] - 2023-09-27
### Added
- Add `@reader_str` and `@writer_str` string macros (#14).

## [0.1.2] - 2022-07-29
### Added
- Add `groupname` and `hasgroupname` methods.
- Support passing varargs and keyword arguments to `T(open(f, ::IO))` methods (#12).

## [0.1.1] - 2021-07-20
### Added
- Add option to do `T(f, ::IO)` where `{T <: AbstractFormattedIO}`. This allows a user to do e.g.
```julia
record = FASTA.Reader(GzipDecompressorStream(open(path))) do reader
    first(iterate(reader))
end
```

## [0.1.0] - 2019-02-08
### Added
- IO module.
- Automa module.
- Exceptions module.
- Testing module.
- Add numerous generic methods.

[Unreleased]: https://github.com/BioJulia/BioGenerics/compare/v0.1.5...HEAD
[0.1.5]: https://github.com/BioJulia/BioGenerics/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/BioJulia/BioGenerics/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/BioJulia/BioGenerics/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/BioJulia/BioGenerics/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/BioJulia/BioGenerics/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/BioJulia/BioGenerics/tree/v0.1.0
