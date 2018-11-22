##########################################
# The crossover genetic operation used in
# genetic programming.
#

struct Crossover <: GeneticOperator
    probability::Float64
end

# Genetic programming crossover genetic operator
function geneticOperation(c::Crossover, state::State, system::System, newPop::Population)
end
