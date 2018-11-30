println("Loading and including files")
using Pkg
Pkg.add("StatsBase")
using StatsBase
include("./Snake/LoadSnake.jl")
include("./GP/LoadGP.jl")

# Individual to test
bestOfStr = "ifFoodDown(ifFoodLeft(moveDown(), ifFoodLeft(moveLeft(), ifFoodUp(moveRight(), moveDown()))), ifFoodUp(ifFoodUp(moveUp(), moveDown()), ifFoodUp(ifFoodUp(moveUp(), moveDown()), ifFoodRight(moveRight(), moveLeft()))))"

#
# Run the best of individual
#

# Setup initial snake game settings
sx = rand(1:30)
sy = rand(1:30)
fa = rand(1:30)
fb = rand(1:30)

# Make sure food and snake don't start in same spot
while sx == fa && sy == fb
    fa = rand(1:30)
    fb = rand(1:30)
end

food = Food(fa, fb)
snakeBlock = SnakeBlock(sx, sy)
snakeArr = SnakeBlock[]
push!(snakeArr, snakeBlock)
snake = Snake(snakeArr)

finalScore = playGameOutput(bestOfStr, snake, food)

println("Individual: ")
println(bestOfStr)
println()

print("Final score:")
println(finalScore)
