##################################################################
# The controller used to run the Snake game when there is output.
#
#include("../model/Board.jl")
#include("../model/Snake.jl")
#include("../model/Block.jl")
#include("../view/PlainText.jl")

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameOutput(brain::Function, initialSnake::Snake, initialFood::Block, sizeX::Int=30, sizeY::Int=30)
	# Start at some starting board
	global currBoard = Board()
	currBoard = Board(sizeX, sizeY, 0, initialSnake, initialFood, "")

	println()
	println(currBoard)
	println(brain)

	# Game loop
	while true
		newMove = eval(Meta.parse(brain))

		if applyMove(currBoard, newMove) == -1
			break
		end

		checkFood(currBoard)
		outputPlainText(currBoard)
		sleep(0.1)
	end

	return currBoard.score
end
