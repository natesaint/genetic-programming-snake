############################################
# Represent the population of a generation.
#
#include("./Individual.jl")
#include("../Problem/FunctionSet.jl")
#include("../Problem/TerminalSet.jl")
#include("../../Snake/model/Board.jl")

struct Population
    members::Array{Individual}
    fitness::Array{Int}

    Population() = new(Individual[], Int[])
end

# Add individual to the population
function addIndividual(pop::Population, ind::Individual)
    push!(pop.members, ind)
end

# Get the number of individuals in the population
function getNumIndividuals(pop::Population)
    return length(pop.members)
end

# Clear the population
function clearPopulation(pop::Population)
    pop = Population()
end

# Create an initial random population
function createInitialPopulation(pop::Population, popSize::Int, funcSet::FunctionSet, termSet::TerminalSet)
    for i = 1:popSize
        # Generate random function and create an internal node with it
        node = InternalNode(chooseRand(funcSet))
        #genRandomIndividual(funcSet, termSet, node, 5, 0)
        genRandomIndividual(funcSet, termSet, node, 2, 0)
        indiv = Individual(node)
        #printIndividual(indiv)
        #println(parseTreeStr(indiv.root))
        #println()
        addIndividual(pop, indiv)
    end
end
