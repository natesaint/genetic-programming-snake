#########################################################
# Represent the current board that Snake is being played
# on. Contains a snake, food, and score.
#

mutable struct Board
	width::Int
	height::Int
	score::Int
	snake::Snake
	food::Food
	move::Symbol#String # Value to change when deciding on move

	Board() = new()
	Board(w, h, s, sk, f, m) = new(w, h, s, sk, f, m)
end
