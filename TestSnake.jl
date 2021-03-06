println("Loading and including files")
using Pkg
Pkg.add("StatsBase")
using StatsBase
include("./Snake/LoadSnake.jl")
include("./GP/LoadGP.jl")

# Individual to test

# This one achieved a score of 114
bestOfStr = "ifFoodAhead(forward(), ifFoodUp(ifDangerTwoAhead(ifDangerAhead(turnLeft(), forward()), ifDangerRight(forward(), ifMovingDown(ifMovingDown(ifFoodUp(turnRight(), ifFoodAhead(turnRight(), turnRight())), ifDangerAhead(turnLeft(), forward())), ifDangerAhead(turnRight(), forward())))), ifMovingRight(ifDangerLeft(turnLeft(), ifFoodLeft(forward(), ifFoodAhead(ifMovingRight(ifDangerTwoAhead(forward(), ifMovingDown(turnLeft(), forward())), turnLeft()), turnRight()))), ifDangerRight(ifDangerTwoAhead(turnLeft(), ifDangerRight(ifDangerAhead(ifDangerAhead(turnLeft(), ifMovingRight(turnLeft(), turnRight())), forward()), ifFoodAhead(forward(), ifMovingLeft(turnLeft(), turnRight())))), ifDangerTwoAhead(ifMovingRight(ifMovingDown(forward(), turnLeft()), turnLeft()), ifMovingLeft(ifMovingDown(forward(), turnLeft()), ifMovingLeft(ifDangerAhead(turnRight(), turnRight()), turnRight())))))))"

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
