#############################################
# The reproduction genetic operation used in
# genetic programming.
#

struct Reproduction <: GeneticOperator
    probability::Float64
end

# Add the selected individual to the new population
function geneticOperation(r::Reproduction, state::State, system::System, newPop::Population)
    addIndividual(newPop, deepcopy(selectIndividual(system.selectionStrategy, state.currPopulation)))
end
