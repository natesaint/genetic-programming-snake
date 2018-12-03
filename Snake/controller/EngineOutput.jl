##################################################################
# The controller used to run the Snake game when there is output.
#

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameOutput(brain::String, initialSnake::Snake, initialFood::Block, sizeX::Int=30, sizeY::Int=30, stopAt::Int=200)
	# Start at some starting board
	global currBoard = Board()
	currBoard = Board(sizeX, sizeY, 0, initialSnake, initialFood, :up)
	numWithoutFood = 0

	#println()
	#println(currBoard)
	#println(brain)

	# Game loop
	while true
		newMove = eval(Meta.parse(brain))
		#newMove = "up"
		#newMove = chooseRandDirection()

		if applyMove(currBoard, newMove) == -1
			break
		end

		if checkFood(currBoard) == 0
			if numWithoutFood > stopAt
				break
			end
			numWithoutFood = numWithoutFood + 1
		else
			numWithoutFood = 0
		end

		outputPlainText(currBoard)
		sleep(0.1)
	end

	return currBoard.score
end
