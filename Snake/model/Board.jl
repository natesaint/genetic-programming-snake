#########################################################
# Represent the current board that Snake is being played
# on. Contains a snake, food, and score.
#
include("./Snake.jl")
include("./Food.jl")

abstract type AbstractBoard end

struct Board <: AbstractBoard
	width::Int
	height::Int
	score::Int
	snake::AbstractSnake
	food::Food
end