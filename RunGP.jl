########################################################
# Run an instance of the genetic programming algorithm.
#
include("./GP/GeneticProgramming.jl")
include("./GP/System/System.jl")
include("./GP/System/Selection/Selection.jl")
include("./GP/System/Selection/FitnessProportionalSelection.jl")
include("./GP/System/Selection/TournamentSelection.jl")
include("./GP/System/GeneticOperator/GeneticOperator.jl")
include("./GP/System/GeneticOperator/Crossover.jl")
include("./GP/System/GeneticOperator/Reproduction.jl")
include("./Snake/controller/EngineNoOutput.jl")
include("./GP/Problem/FunctionSet.jl")
include("./GP/Problem/TerminalSet.jl")
include("./GP/Problem/TerminationCriterion.jl")

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

#createSystem(gp, 500, 200, strat, ops)
createSystem(gp, 5, 3, strat, ops)

#
# Construct problem
#

# Add functions
functionSet = Function[]
push!(functionSet, connector)
push!(functionSet, ifFoodAhead)
push!(functionSet, ifDangerAhead)
push!(functionSet, ifDangerRight)
push!(functionSet, ifDangerLeft)
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

#dump(gp)

runGP(gp)
