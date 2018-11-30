#################################################
# Housing for the genetic programming algorithm.
#

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
        #println(selectedOp)

        # Make sure crossover doesn't happen if only one more indiviudal can fit
        if (gp.system.popSize - 1 == getNumIndividuals(newPop))
            geneticOperation(Reproduction(1.0), gp.state, gp.system, newPop)
        else
            geneticOperation(selectedOp, gp.state, gp.system, newPop)
        end
    end

    gp.state.currPopulation = deepcopy(newPop)
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
    gp.state.bestOf = deepcopy(gp.state.currPopulation.members[1])
    gp.state.bestOfFitness = calculateAvgFitness(gp.problem.eval, gp.problem.eval.numRunsPerFitnessTest, gp.state.currPopulation.members[1]).score

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
            print("\rIndividual #")
            print(i)
            print("/")
            print(gp.system.popSize)
            #visualizeTree(gp.state.currPopulation.members[i].root, 0)
            push!(gp.state.currPopulation.fitness, calculateAvgFitness(gp.problem.eval, gp.problem.eval.numRunsPerFitnessTest, gp.state.currPopulation.members[i]))

            # Check termination criterion
            if (gp.problem.terminationCriterion(gp.state.currPopulation.fitness[i].score, 30, 30))
                println("Termination criterion satisfied - returning 'best of' individual")
                return gp.state.currPopulation.members[i]
            end

            # Check if best of individual should be updated
            if gp.state.currPopulation.fitness[i].score >= gp.state.bestOfFitness
                gp.state.bestOf = deepcopy(gp.state.currPopulation.members[i])
                gp.state.bestOfFitness = gp.state.currPopulation.fitness[i].score
            end

            i = i + 1
        end

        println()
        println("Best individual after this generation:")
        print("Fitness: ")
        println(gp.state.bestOfFitness)
        println(parseTreeStr(gp.state.bestOf.root))
        println()

        # Save the best of individual of this generation TODO

        # Perform genetic operators to create a new population with evolve()
        evolve(gp)

        incrementGeneration(gp.state)
    end

    return gp.state.bestOf
end

# Output the starting configuration of GP
function printInitialConfig(gp::GeneticProgramming)
    println()
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
