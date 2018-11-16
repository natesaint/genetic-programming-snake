#####################################################################
# The controller used to run the Snake game when there is no output.
#
include("../model/Board.jl")
include("../model/Snake.jl")
include("../model/Block.jl")

# Function to play Snake, the snake brain is passed to the function in the
# place of deciding which direction to move in.
function playGameNoOutput(brain::Function, initialSnake::Snake, initialFood::Block, sizeX::Int, sizeY::Int)
	board = Board(sizeX, sizeY, 0, initialSnake, initialFood)
end
