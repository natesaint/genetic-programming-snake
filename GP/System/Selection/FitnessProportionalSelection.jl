########################################################
# Fitness Proportional Selection strategy for selecting
# individuals.
#
#include("./Selection.jl")
#include("../../State/Population.jl")

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
