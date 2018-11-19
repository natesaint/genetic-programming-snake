#################################################
# Housing for the genetic programming algorithm.
#
#using Pkg
#Pkg.add("StatsBase")
#using StatsBase
#include("./State/State.jl")
#include("./System/System.jl")
#include("./Problem/Problem.jl")
#include("./Problem/FunctionSet.jl")
#include("./Problem/TerminalSet.jl")
#include("./System/Selection/Selection.jl")
#include("./System/GeneticOperator/GeneticOperator.jl")
#include("./System/GeneticOperator/Crossover.jl")
#include("./System/GeneticOperator/Reproduction.jl")
#include("./State/Population.jl")
#include("./Problem/FitnessEval.jl")

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
function createProblem(gp::GeneticProgramming, fitnessFunction::Function, numRunsPerFitnessTest::Int, functionSet::Array{Function}, terminalSet::Array{Function}, terminationFunc::Function)
    gp.problem = Problem(fitnessFunction, terminationFunc, numRunsPerFitnessTest)

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
    newPop = Population()

    # Setup for sampling
    weights = Float64[]
    for op in gp.system.geneticOperators
        push!(weights, op.probability)
    end

    # While the new population is less than the number of indivs per population,
    # keep adding new idividuals using the genetic operation selected via
    # sampling
    while getNumIndividuals(newPop) < gp.system.popSize
        # With sampling, choose the genetic operation to use
        selectedOp = wsample(gp.system.geneticOperators, weights)

        # Make sure crossover doesn't happen if only one more indiviudal can fit
        if (gp.system.popSize - 1 == getNumIndividuals(newPop))
            geneticOperation(Reproduction(1.0), gp.state, gp.system, newPop)
        else
            geneticOperation(selectedOp, gp.state, gp.system, newPop)
        end
    end

    gp.state.currPopulation = newPop
end

# Run the GP process looping through the procedure until the maximum number
# of generations is reached or the satisfaction criterion is. Return the
# best of individual.
function runGP(gp::GeneticProgramming)
    printInitialConfig(gp)

    # Create initial population
    println("Creating initial random population")
    createInitialPopulation(gp.state.currPopulation, gp.system.popSize, gp.problem.functionSet, gp.problem.terminalSet)
    println("Initial population created\n")

    # Set best of to the first individual in the population with fitness 0
    gp.state.bestOf = gp.state.currPopulation.members[1]

    # Main loop for genetic programming
    while gp.state.generation < gp.system.numGen
        i = 1

        print("Generation ")
        println(gp.state.generation + 1)

        # Calculate fitness of each individual in the current population and
        # check termination criterion
        println("Calculating fitness of each individual")
        while i <= gp.system.popSize
            # Calculate avg fitness over 5 runs
            #println("Calculating average fitness")
            push!(gp.state.currPopulation.fitness, calculateAvgFitness(gp.problem.eval, gp.problem.eval.numRunsPerFitnessTest, gp.state.currPopulation.members[i]))
            #print("Average fitness over ")
            #print(gp.problem.eval.numRunsPerFitnessTest)
            #print(" runs is ")
            #println(gp.state.currPopulation.fitness[i])

            # Check termination criterion
            if (gp.problem.terminationCriterion(gp.state.currPopulation.fitness[i], 30, 30))
                println("Termination criterion satisfied - returning 'best of' individual")
                return gp.state.currPopulation.members[i]
            end

            i = i + 1
        end

        # Save the best of individual for this generation

        # Perform genetic operators to create a new population with evolve()
        evolve(gp)

        incrementGeneration(gp.state)
        println()
    end

    return gp.state.bestOf
end

# Output the starting configuration of GP
function printInitialConfig(gp::GeneticProgramming)
    println("=====================")
    println("    Configuration    ")
    println("=====================")

    print("Generations: ")
    println(gp.system.numGen)
    print("Individuals per generation: ")
    println(gp.system.popSize)

    print("Selection strategy: ")
    println(gp.system.selectionStrategy)

    print("Genetic operators: ")
    println(gp.system.geneticOperators)

    println("Fitness evaluation: ")
    print("    Function: ")
    println(gp.problem.eval.fitnessFunc)
    print("    Number of runs per test: ")
    println(gp.problem.eval.numRunsPerFitnessTest)

    print("Function set: ")
    println(gp.problem.functionSet.functions)
    print("Terminal set: ")
    println(gp.problem.terminalSet.terminals)

    print("Termination criterion: ")
    println(gp.problem.terminationCriterion)
    println()

    println("==================")
    println("    Running GP    ")
    println("==================")
end
