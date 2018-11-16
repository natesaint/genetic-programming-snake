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

gp = GeneticProgramming()

#
# Construct system
#

# Selection strategy to use
strat = FitnessProportionalSelection()

# Genetic operators to use in gp
ops = GeneticOperator[]
push!(ops, Crossover())
push!(ops, Reproduction())

createSystem(gp, 500, 200, strat, ops)

#
# Construct problem
#

# Add functions
functionSet = Function[]
push!(functionSet, isFood)

# Add terminals
terminalSet = Function[]
push!(terminalSet, moveLeft)
push!(terminalSet, moveRight)

createProblem(gp, playGameNoOutput, functionSet, terminalSet)

#
# Construct initial state
#
createInitState(gp)

dump(gp)
println("\n")

runGP(gp, 2)
