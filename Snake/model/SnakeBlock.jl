##################################
# Represent a block of the Snake.
#
include("./Block.jl")

struct SnakeBlock <: Block
	x::Int
	y::Int
end