##################################
# Represent a block of the Snake.
#
#include("./Block.jl")

mutable struct SnakeBlock <: Block
	x::Int
	y::Int
end
