#############################################
# Represent an individual in the popualtion.
#
include("./TreeNode.jl")
include("./InternalNode.jl")

struct Individual
    root::TreeNode
    fitness::Int

    Individual(rootNode) = new(rootNode, 0)
end
