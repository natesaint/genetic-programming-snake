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
function createProblem(gp::GeneticProgramming, fitnessFunction::Function, functionSet::Array{Function}, terminalSet::Array{Function}, terminationFunc::Function)
    gp.problem = Problem(fitnessFunction, terminationFunc)

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
    printInitialConfig(gp)

    # Create initial population
    createInitialPopulation(gp.state.currPopulation, gp.system.popSize)

    # Set best of to the first individual in the population with fitness 0

    # Main loop for genetic programming
    while gp.state.generation < gp.system.numGen
        i = 1

        print("Generation ")
        println(gp.state.generation)

        # Calculate fitness of each individual in the current population and
        # check termination criterion
        while i <= gp.system.popSize
            # Calculate fitness


            # Check termination criterion
            if (gp.problem.terminationCriterion(gp.state.currPopulation[i].fitness, 30, 30))
                return gp.state.currPopulation[i]
            end

            i = i + 1
        end

        incrementGeneration(gp.state)
        println()
    end

    return gp.state.bestOf
end

# Output the starting configuration of GP
function printInitialConfig(gp::GeneticProgramming)
    println("##################################")
    println("###                            ###")
    println("### Genetic Programming Config ###")
    println("###                            ###")
    println("##################################\n")

    print("Generations: ")
    println(gp.system.numGen)
    print("Individuals per generation:")
    println(gp.system.popSize)

    print("Selection strategy: ")
    println(gp.system.selectionStrategy)

    println("\n")
end
