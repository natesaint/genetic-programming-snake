#############################################
# The reproduction genetic operation used in
# genetic programming.
#
include("./GeneticOperator.jl")
include("../../State/State.jl")
include("../../State/Population.jl")
include("../../State/Individual.jl")
include("../System.jl")
include("../Selection/FitnessProportionalSelection.jl")
include("../Selection/TournamentSelection.jl")

struct Reproduction <: GeneticOperator
    probability::Float64
end

# Add the selected individual to the new population
function geneticOperation(r::Reproduction, state::State, system::System, newPop::Population)
    addIndividual(newPop, selectIndividual(system.selectionStrategy, state.currPopulation))
end
