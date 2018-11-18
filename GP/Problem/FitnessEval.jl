#########################################################
# Functionality to evaluate the fitness of an individual
# or a set of individuals.
#
include("../State/Individual.jl")
include("../../Snake/model/Board.jl")
include("../State/TreeNode.jl")
include("../../Snake/controller/EngineNoOutput.jl")
include("../../Snake/model/Food.jl")
include("../../Snake/model/Snake.jl")
include("../../Snake/model/SnakeBlock.jl")

struct FitnessEval
    fitnessFunc::Function
    numRunsPerFitnessTest::Int
end

# Run the fitness test numRuns amount of times
function calculateAvgFitness(fe::FitnessEval, numRuns::Int, snakeBrain::Individual)
    fitSum = 0
    for i in 1:fe.numRunsPerFitnessTest
        fitSum = fitSum + evaluateFitness(fe, snakeBrain)
    end
    return fitSum / fe.numRunsPerFitnessTest
end

# Evaluate the fitness by getting the expression from the tree and checking it
function evaluateFitness(fe::FitnessEval, snakeBrain::Individual)
    # Get the parsed string of the current individual being tested
    exprStr = parseTreeStr(snakeBrain.root)
    #println(exprStr)
    #println()

    # Setup initial snake game settings
    x = rand(1:30)
    y = rand(1:30)
    a = x
    b = y

    # Make sure food and snake don't start in same spot
    while x == a && y == b
        a = rand(1:30)
        b = rand(1:30)
    end

    food = Food(a, b)
    snakeBlock = SnakeBlock(x, y)
    snakeArr = SnakeBlock[]
    push!(snakeArr, snakeBlock)
    snake = Snake(snakeArr)

    return fe.fitnessFunc(exprStr, snake, food)
    #return 800#900
end
