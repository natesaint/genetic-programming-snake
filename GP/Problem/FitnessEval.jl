#########################################################
# Functionality to evaluate the fitness of an individual
# or a set of individuals.
#
include("../State/Individual.jl")

struct FitnessEval
    fitnessFunc::Function
end

function evaluateFitness(fe::FitnessEval, snakeBrain::Individual)
end

function calculateAvgFitness(fe::FitnessEval, numRuns::Int, snakeBrain::Individual)
end
