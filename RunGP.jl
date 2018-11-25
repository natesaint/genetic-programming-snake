########################################################
# Run an instance of the genetic programming algorithm.
#
println("Loading and including files")
using Pkg
Pkg.add("StatsBase")
using StatsBase
include("./Snake/LoadSnake.jl")
include("./GP/LoadGP.jl")
println("Done loading and including files")

gp = GeneticProgramming()

#
# Construct system
#

# Selection strategy to use
strat = FitnessProportionalSelection()

# Genetic operators to use in gp
ops = GeneticOperator[]
push!(ops, Crossover(0.90))
push!(ops, Reproduction(0.10))

createSystem(gp, 10000, 200, strat, ops)
#createSystem(gp, 10, 20, strat, ops)
#createSystem(gp, 2, 3, strat, ops)

#
# Construct problem
#

# Add functions
functionSet = Function[]
#push!(functionSet, connector)
push!(functionSet, ifFoodAhead)
push!(functionSet, ifDangerAhead)
push!(functionSet, ifDangerRight)
push!(functionSet, ifDangerLeft)
push!(functionSet, ifDangerTwoAhead)
push!(functionSet, ifFoodUp)
push!(functionSet, ifFoodRight)
push!(functionSet, ifMovingUp)
push!(functionSet, ifMovingDown)
push!(functionSet, ifMovingLeft)
push!(functionSet, ifMovingRight)


# Add terminals
terminalSet = Function[]
push!(terminalSet, moveUp)
push!(terminalSet, moveDown)
push!(terminalSet, moveLeft)
push!(terminalSet, moveRight)

createProblem(gp, playGameNoOutput, 5, functionSet, terminalSet, isMaxScoreRectangleBoard)

#
# Construct initial state
#
createInitState(gp)

#
# Run GP - save best of individual
#
bestOf = runGP(gp)
bestOfStr = parseTreeStr(bestOf.root)

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

println("Best individual: ")
println(bestOfStr)
println()

print("Final score:")
println(finalScore)
