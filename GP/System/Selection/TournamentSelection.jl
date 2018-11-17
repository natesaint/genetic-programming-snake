###########################################################
# Tournament Selection strategy for selecting individuals.
#
include("./Selection.jl")
include("../../State/Population.jl")

struct TournamentSelection <: Selection
end

function selectIndividual(strat::TournamentSelection, pop::Population)
end
