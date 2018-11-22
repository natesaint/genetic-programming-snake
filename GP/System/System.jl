############################################################
# Represent elements of the genetic programming system used
# for running the GP algorithm for all problem domains.
#

mutable struct System
    popSize::Int
    numGen::Int
    selectionStrategy::Selection
    geneticOperators::Array{GeneticOperator}

    System(popSize, numGen) = new(popSize, numGen)
end

function chooseSelectionStrategy(sys::System, strat::Selection)
    sys.selectionStrategy = strat
end

function chooseGeneticOperators(sys::System, ops::Array{GeneticOperator})
    sys.geneticOperators = GeneticOperator[]
    for op in ops
        push!(sys.geneticOperators, op)
    end
end
