########################################################
# Fitness Proportional Selection strategy for selecting
# individuals.
#

struct FitnessProportionalSelection <: Selection
end

function selectIndividual(strat::FitnessProportionalSelection, pop::Population)
    weights = Float64[]
    s = sum(pop.fitness)

    if s == 0
        return pop.members[rand(1:length(pop.members))]
    end

    for x in pop.fitness
        push!(weights, x / s)
    end

    return wsample(pop.members, weights)
end
