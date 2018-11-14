###############################################
# Represent attributes stored as a part of the
# current state of GP.
#
include("./Population.jl")

struct State
    generation::Int
    currPopulation::Population
end
