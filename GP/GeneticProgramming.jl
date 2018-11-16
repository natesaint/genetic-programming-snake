#################################################
# Housing for the genetic programming algorithm.
#
include("./State/State.jl")
include("./System/System.jl")
include("./Problem/Problem.jl")
include("./Problem/FunctionSet.jl")
include("./Problem/TerminalSet.jl")
include("./System/Selection/Selection.jl")
include("./System/GeneticOperator/GeneticOperator.jl")
include("./State/Population.jl")

mutable struct GeneticProgramming
    system::System
    problem::Problem
    state::State

    GeneticProgramming() = new()
end

# Create system object, choose selection and genetic operators
function createSystem(gp::GeneticProgramming, popSize::Int, numGen::Int, strat::Selection, ops::Array{GeneticOperator})
    gp.system = System(popSize, numGen)
    chooseSelectionStrategy(gp.system, strat)
    chooseGeneticOperators(gp.system, ops)
end

# Create problem object
function createProblem(gp::GeneticProgramming, fitnessFunction::Function, functionSet::Array{Function}, terminalSet::Array{Function})
    gp.problem = Problem(fitnessFunction)

    for func in functionSet
        addFunction(gp.problem.functionSet, func)
    end

    for terminal in terminalSet
        addTerminal(gp.problem.terminalSet, terminal)
    end
end

# Create initial state for gp
function createInitState(gp::GeneticProgramming)
    gp.state = State(0, Population())
end

function evolve(gp::GeneticProgramming)
end

function runGP(gp::GeneticProgramming)
end
