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

	currBoard.move = chooseRandDirection()

	println(brain)

	# Game loop
	println(currBoard.move)
	eval(Meta.parse(brain)) ## HERE IS THE PROBLEM CURRENTLY
	println(currBoard.move)
	while true
	end

	return currBoard.score
end

# Choose random direction
function chooseRandDirection()
	directions = ["up", "down", "right", "left"]
	return directions[rand(1:4)]
end
