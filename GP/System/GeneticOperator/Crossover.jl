##########################################
# The crossover genetic operation used in
# genetic programming.
#
include("./GeneticOperator.jl")
include("../../State/State.jl")
include("../../State/Population.jl")
include("../../State/Individual.jl")

struct Crossover <: GeneticOperator
    probability::Float64
end

# Genetic programming crossover genetic operator
function geneticOperation(c::Crossover, state::State, system::System, newPop::Population)
end
