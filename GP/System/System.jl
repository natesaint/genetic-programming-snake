############################################################
# Represent elements of the genetic programming system used
# for running the GP algorithm for all problem domains.
#
include("./Selection/Selection.jl")
include("./GeneticOperator/GeneticOperator.jl")

struct System
    selectionStrategy::Selection
    geneticOperators::Array{GeneticOperator}
    popSize::Int
    numGen::Int
end

function chooseSelectionStrategy(sys::System)
end
