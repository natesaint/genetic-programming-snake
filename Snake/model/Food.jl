################################
# Represents the food in Snake.
#
#include("./Block.jl")

mutable struct Food <: Block
	x::Int
	y::Int
end
