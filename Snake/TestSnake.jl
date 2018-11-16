include("./controller/EngineOutput.jl")
include("./model/Block.jl")
include("./model/Board.jl")
include("./model/Food.jl")
include("./model/Snake.jl")
include("./model/SnakeBlock.jl")

snakeBlock = SnakeBlock(5, 5)
snakeArr = SnakeBlock[]
push!(snakeArr, snakeBlock)
snake = Snake(snakeArr)
food = Food(10, 10)

function sampleBrain()
	return 1
end

playGameOutput(sampleBrain, snake, food, 30, 30)
