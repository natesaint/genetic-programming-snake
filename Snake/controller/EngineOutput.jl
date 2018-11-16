##################################################################
# The controller used to run the Snake game when there is output.
#
include("../model/Board.jl")
include("../model/Snake.jl")
include("../model/Block.jl")
include("../view/PlainText.jl")

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameOutput(brain::Function, initialSnake::Snake, initialFood::Block, sizeX::Int, sizeY::Int)
	board = Board(sizeX, sizeY, 0, initialSnake, initialFood)

	outputPlainText(board)
end
