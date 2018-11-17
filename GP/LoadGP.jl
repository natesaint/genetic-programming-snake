##################################################
# Load files to be used with genetic programming.
#

include("GeneticProgramming.jl")

include("./Problem/FitnessEval.jl")
include("./Problem/FunctionSet.jl")
include("./Problem/Problem.jl")
include("./Problem/TerminalSet.jl")
include("./Problem/TerminationCriterion.jl")

include("./State/Individual.jl")
include("./State/InternalNode.jl")
include("./State/LeafNode.jl")
include("./State/Population.jl")
include("./State/State.jl")
include("./State/TreeNode.jl")

include("./System/System.jl")
include("./System/GeneticOperator/Crossover.jl")
include("./System/GeneticOperator/GeneticOperator.jl")
include("./System/GeneticOperator/Reproduction.jl")
include("./System/Selection/Selection.jl")
include("./System/Selection/FitnessProportionalSelection.jl")
include("./System/Selection/TournamentSelection.jl")
