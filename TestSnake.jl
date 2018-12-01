println("Loading and including files")
using Pkg
Pkg.add("StatsBase")
using StatsBase
include("./Snake/LoadSnake.jl")
include("./GP/LoadGP.jl")

# Individual to test

# This one achieved a score of 87 with the current settings
bestOfStr = "ifFoodAhead(forward(), ifFoodUp(ifDangerTwoAhead(turnLeft(), ifDangerRight(forward(), ifMovingDown(ifFoodUp(ifFoodUp(forward(), ifFoodUp(forward(), ifFoodAhead(turnRight(), forward()))), ifFoodLeft(turnRight(), turnLeft())), ifDangerAhead(turnRight(), turnRight())))), ifMovingRight(ifDangerLeft(ifFoodLeft(ifDangerRight(ifFoodAhead(forward(), ifFoodUp(turnLeft(), forward())), ifMovingDown(ifFoodUp(turnRight(), ifFoodAhead(turnRight(), turnRight())), ifDangerAhead(turnLeft(), forward()))), turnLeft()), ifFoodLeft(forward(), ifDangerTwoAhead(ifMovingRight(turnLeft(), turnLeft()), ifMovingLeft(forward(), turnRight())))), ifDangerRight(ifDangerTwoAhead(turnLeft(), ifDangerRight(ifFoodAhead(ifDangerAhead(turnLeft(), forward()), turnLeft()), ifMovingDown(ifFoodUp(turnRight(), ifFoodUp(turnRight(), forward())), ifDangerAhead(ifMovingRight(turnLeft(), turnRight()), turnLeft())))), ifDangerTwoAhead(ifMovingRight(turnLeft(), turnLeft()), forward())))))"

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
