#########################################################
# Represent the current board that Snake is being played
# on. Contains a snake, food, and score.
#
include("./Snake.jl")
include("./Food.jl")

struct Board
	width::Int
	height::Int
	score::Int
	snake::Snake
	food::Food
end
