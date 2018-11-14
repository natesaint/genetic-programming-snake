##############################
# Represent the actual Snake.
#
include("./SnakeBlock.jl")

struct Snake
	snake::Array{SnakeBlock}
end
