###########################################################
# Tournament Selection strategy for selecting individuals.
#
include("./Selection.jl")

struct TournamentSelection <: Selection
end

function selectIndividual(strat::TournamentSelection)
end
