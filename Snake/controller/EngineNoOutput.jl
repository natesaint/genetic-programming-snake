#####################################################################
# The controller used to run the Snake game when there is no output.
#
include("../model/Board.jl")
include("../model/Snake.jl")
include("../model/Block.jl")

currBoard = Board()

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameNoOutput(brain::String, initialSnake::Snake, initialFood::Block, sizeX::Int=30, sizeY::Int=30)
	currBoard = Board(sizeX, sizeY, 0, initialSnake, initialFood, "")

	return currBoard.score
end
