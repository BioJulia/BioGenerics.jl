module Automa

# `S` is the stream being parsed, typically a `TranscodingStreams.TranscodingStream`.
mutable struct State{S}
    # Stream
    stream::S
    # Machine state
    state::Int
    # Line number
    linenum::Int
    # Is record filled?
    filled::Bool
end

end # module
