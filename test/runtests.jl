using BioGenerics
using Test
using TranscodingStreams

@testset "BioGenerics" begin
    @testset "Automa.State" begin
        # Parsers construct the state from a TranscodingStream.
        stream = NoopStream(IOBuffer("chr1\t1\t2\n"))
        state = BioGenerics.Automa.State(stream, 1, 1, false)
        @test state isa BioGenerics.Automa.State{typeof(stream)}
        @test state.stream === stream
        @test (state.state, state.linenum, state.filled) == (1, 1, false)

        # Any stream type is accepted.
        @test BioGenerics.Automa.State(IOBuffer(), 1, 1, false) isa BioGenerics.Automa.State{IOBuffer}
    end

    @testset "No dependencies" begin
        project = joinpath(pkgdir(BioGenerics), "Project.toml")
        @test !occursin("[deps]", read(project, String))
    end
end
