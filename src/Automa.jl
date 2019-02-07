module Automa

import TranscodingStreams: TranscodingStream

mutable struct State{S <: TranscodingStream}
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