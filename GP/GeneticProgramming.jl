#################################################
# Housing for the genetic programming algorithm.
#
include("./State/State.jl")
include("./System/System.jl")
include("./Problem/Problem.jl")
include("./Problem/FunctionSet.jl")
include("./Problem/TerminalSet.jl")
include("./System/Selection/Selection.jl")
include("./System/GeneticOperator/GeneticOperator.jl")
include("./State/Population.jl")

mutable struct GeneticProgramming
    system::System
    problem::Problem
    state::State

    GeneticProgramming() = new()
end

# Create system object, choose selection and genetic operators
function createSystem(gp::GeneticProgramming, popSize::Int, numGen::Int, strat::Selection, ops::Array{GeneticOperator})
    gp.system = System(popSize, numGen)
    chooseSelectionStrategy(gp.system, strat)
    chooseGeneticOperators(gp.system, ops)
end

# Create problem object
function createProblem(gp::GeneticProgramming, fitnessFunction::Function, functionSet::Array{Function}, terminalSet::Array{Function})
    gp.problem = Problem(fitnessFunction)

    for func in functionSet
        addFunction(gp.problem.functionSet, func)
    end

    for terminal in terminalSet
        addTerminal(gp.problem.terminalSet, terminal)
    end
end

# Create initial state for gp
function createInitState(gp::GeneticProgramming)
    gp.state = State(0, Population())
end

# Given a current population, evolve it and produce the next one
function evolve(gp::GeneticProgramming)
end

# Run the GP process looping through the procedure until the maximum number
# of generations is reached or the satisfaction criterion is. Return the
# best of individual.
#
# Mode represents the output mode
# 0 - None
# 1 - Simple
# 2 - Verbose
function runGP(gp::GeneticProgramming, view::Int)
    # Create initial population

    # Main loop for genetic programming
    while gp.state.generation < gp.system.numGen
        print("Generation ")
        println(gp.state.generation + 1)

        # Check termination criterion
        println("Checking termination criterion")



        incrementGeneration(gp.state)
        println()
    end

    #return gp.state.bestOf
end
