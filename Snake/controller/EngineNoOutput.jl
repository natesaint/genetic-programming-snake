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
	while true
		#newMove = eval(Meta.parse(brain))
		newMove = "right"
		println(newMove)

		if applyMove(currBoard, newMove) == -1
			break
		end

		checkFood(b)
		outputPlainText(currBoard)
		sleep(0.2)
	end

	return currBoard.score
end

# Update the head of the snake based on the move, return -1 on collision (game over)
function applyMove(b::Board, move::String)
	newSnakeBlock = SnakeBlock(-1, -1)
	if move == "up"
		newSnakeBlock.x = b.snake.snake[1].x
		newSnakeBlock.y = b.snake.snake[1].y - 1
	elseif move == "down"
		newSnakeBlock.x = b.snake.snake[1].x
		newSnakeBlock.y = b.snake.snake[1].y + 1
	elseif move == "left"
		newSnakeBlock.x = b.snake.snake[1].x - 1
		newSnakeBlock.y = b.snake.snake[1].y
	elseif move == "right"
		newSnakeBlock.x = b.snake.snake[1].x + 1
		newSnakeBlock.y = b.snake.snake[1].y
	else
		return -1
	end

	# Check if new block is out of bounds
	if newSnakeBlock.x <= 0 || newSnakeBlock.y <= 0 || newSnakeBlock.x > b.width || newSnakeBlock.y > b.height
		return -1
	end

	# Check if new block collides with another snake block
	for i in 1:(length(b.snake.snake) - 1)
		if b.snake.snake[i].x == newSnakeBlock.x && b.snake.snake[i].y == newSnakeBlock.y
			return -1
		end
	end

	# Update the snake array
	if length(b.snake.snake) != 1
		for i in length(b.snake.snake):2
			b.snake.snake[i] = b.snake.snake[i - 1]
		end
	end
	b.snake.snake[1] = newSnakeBlock

	return 0
end

# Check if food is eaten
function checkFood(b::Board)
	if b.snake.snake[0].x == b.food.x && b.snake.snake[0].y == b.food.y
		b.score = b.score + 1
		genNewFood(b)
	end
end

# Generate a new piece of food not in the position of the snake
function genNewFood(b::Board)
	newFood = Food(rand(1:b.width), rand(1:b.length))

	while collidesWithSnake(b.snake, newFood.x, newFood.y)
        newFood = Food(rand(1:b.width), rand(1:b.length))
    end

	b.food = newFood
end

function collidesWithSnake(s::Snake, x::Int, y::Int)
	for sb in s.snake
		if sb.x == x && sb.y == y
			return true
		end
	end
	return false
end

# Choose random direction
function chooseRandDirection()
	directions = ["up", "down", "right", "left"]
	return directions[rand(1:4)]
end
