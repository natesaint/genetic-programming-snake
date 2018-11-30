############################################
# Represent the population of a generation.
#

struct Population
    members::Array{Individual}
    fitness::Array{Any}

    Population() = new(Individual[], Any[])
end

# Add individual to the population
function addIndividual(pop::Population, ind::Individual)
    push!(pop.members, deepcopy(ind))
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
        cnt = Count(1)
        node = InternalNode(chooseRand(funcSet))
        genRandomIndividual(funcSet, termSet, node, 5, 0, cnt)
        #genRandomIndividual(funcSet, termSet, node, 2, 0, cnt)
        #println(cnt.count)
        #visualizeTree(node, 0)
        #println()
        indiv = Individual(node)
        indiv.numNodes = cnt.count
        addIndividual(pop, indiv)
    end
end
