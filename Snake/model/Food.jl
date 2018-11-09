################################
# Represents the food in Snake.
#
include("./Block.jl")

struct Food <: Block
	x::Int
	y::Int
end

