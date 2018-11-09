#########################################
# The engine used to run the Snake game.
#
include("../model/Board.jl")
include("../view/PlainText.jl")

########################################################
# Function to play Snake, the snake brain is passed to
# the function in the place of deciding which direction
# to move in.
#
function playGame(brain::Function, viewMode::Int, initialSnake::AbstractSnake, initialFood::Block)
	board = Board(30, 30, 0, initialSnake, initialFood)

	if viewMode == 1
		outputPlainText(board)
	end
end