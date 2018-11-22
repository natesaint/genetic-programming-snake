########################################################
# Fitness Proportional Selection strategy for selecting
# individuals.
#

struct FitnessProportionalSelection <: Selection
end

function selectIndividual(strat::FitnessProportionalSelection, pop::Population)
    weights = Float64[]
    s = sum(pop.fitness)

    for x in pop.fitness
        push!(weights, x / s)
    end

    return wsample(pop.members, weights)
end
