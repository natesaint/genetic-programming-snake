#############################
# Represent the actual Snake
#
include("./SnakeBlock.jl")

abstract type AbstractSnake end

struct Snake <: AbstractSnake
	snake::Array{SnakeBlock}
end