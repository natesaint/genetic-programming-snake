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
	# Start at some starting board
	global currBoard = Board(sizeX, sizeY, 0, initialSnake, initialFood, "")

	currBoard.move = chooseRandDirection()

	println(currBoard)
	println(brain)

	# Game loop
	println(currBoard.move)
	eval(Meta.parse(brain)) ## HERE IS THE PROBLEM CURRENTLY
	println(currBoard.move)
	outputPlainText(currBoard)
	while true
		#eval(Meta.parse(brain))
		#if applyMove(currBoard) == -1
		#	break
		#end
	end

	return currBoard.score
end

# Update the head of the snake based on the move, return -1 on collision (game over)
function applyMove(b::Board)
	println(b.move)
end

# Check if snake is colliding with self or wall
function isGameOver(b::Board)
end

# Check if food is eaten
function checkFood(b::Board)
end

# Generate a new piece of food not in the position of the snake
function genNewFood(b::Board)
end

# Choose random direction
function chooseRandDirection()
	directions = ["up", "down", "right", "left"]
	return directions[rand(1:4)]
end
