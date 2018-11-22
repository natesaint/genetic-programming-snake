###############################################
# Represent attributes stored as a part of the
# current state of GP.
#

mutable struct State
    generation::Int
    currPopulation::Population
    bestOf::Individual
    bestOfFitness::Int

    State(gen, currPop) = new(gen, currPop)
end

function incrementGeneration(s::State)
    s.generation = s.generation + 1
end

function updatePopulation(s::State, newPopulation::Population)
    s.currPopulation = newPopulation
end
