#############################################
# Represent an individual in the popualtion.
#
include("./TreeNode.jl")
include("./InternalNode.jl")
include("../Problem/FunctionSet.jl")
include("../Problem/TerminalSet.jl")

struct Individual
    root::TreeNode

    Individual(rootNode) = new(rootNode)
end

# Choose a function to be the root
function chooseRandFunction(funcSet::FunctionSet)

end

# Recursively, generate random individual assuming it has a root already
function genRandomIndividual(funcSet::FunctionSet, termSet::TerminalSet, rootGenerated::Int)

end
