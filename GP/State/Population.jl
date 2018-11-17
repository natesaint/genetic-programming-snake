############################################
# Represent the population of a generation.
#
include("./Individual.jl")
include("../GeneticProgramming.jl")

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
    return pop.members.length
end

# Clear the population
function clearPopulation(pop::Population)
    pop = Population()
end

# Create an initial random population
function createInitialPopulation(pop::Population, gp::GeneticProgramming)
    #for i = 1:gp.system.popSize
    #    addIndividual(pop, genRandomIndividual())
    #end
end
