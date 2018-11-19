###############################################
# Represent attributes stored as a part of the
# current state of GP.
#
#include("./Population.jl")

mutable struct State
    generation::Int
    currPopulation::Population
    bestOf::Individual

    State(gen, currPop) = new(gen, currPop)
end

function incrementGeneration(s::State)
    s.generation = s.generation + 1
end

function updatePopulation(s::State, newPopulation::Population)
    s.currPopulation = newPopulation
end
