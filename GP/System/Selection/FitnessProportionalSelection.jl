########################################################
# Fitness Proportional Selection strategy for selecting
# individuals.
#
include("./Selection.jl")

struct FitnessProportionalSelection <: Selection
end

function selectIndividual(strat::FitnessProportionalSelection)
end
