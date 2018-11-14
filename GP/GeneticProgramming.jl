#################################################
# Housing for the genetic programming algorithm.
#
include("./State/State.jl")
include("./System/System.jl")
include("./Problem/Problem.jl")

struct GeneticProgramming
    state::State
    system::System
    problem::Problem
end

function evolve(gp::GeneticProgramming)
end

function runGP(gp::GeneticProgramming)
end
