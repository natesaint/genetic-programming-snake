#########################################################
# Functionality to evaluate the fitness of an individual
# or a set of individuals.
#
include("../State/Individual.jl")

struct FitnessEval
    fitnessFunc::Function
    numRunsPerFitnessTest::Int
end

function calculateAvgFitness(fe::FitnessEval, numRuns::Int, snakeBrain::Individual)
    fitSum = 0
    for i in 1:fe.numRunsPerFitnessTest
        fitSum = fitSum + evaluateFitness(fe, snakeBrain)
    end
    return fitSum / fe.numRunsPerFitnessTest
end

function evaluateFitness(fe::FitnessEval, snakeBrain::Individual)
    return 900
end
