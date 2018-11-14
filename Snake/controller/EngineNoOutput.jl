#####################################################################
# The controller used to run the Snake game when there is no output.
#
include("../model/Board.jl")

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameNoOutput(brain::Function, initialSnake::Snake, initialFood::Block)
	board = Board(30, 30, 0, initialSnake, initialFood)
end
