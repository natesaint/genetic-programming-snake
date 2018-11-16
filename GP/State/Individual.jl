#############################################
# Represent an individual in the popualtion.
#
include("./TreeNode.jl")
include("./InternalNode.jl")

struct Individual
    root::TreeNode

    Individual(rootNode) = new(rootNode)
end
