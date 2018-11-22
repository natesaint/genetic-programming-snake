##############################
# Represent the actual Snake.
#
#include("./SnakeBlock.jl")

mutable struct Snake
	snake::Array{SnakeBlock}
end
