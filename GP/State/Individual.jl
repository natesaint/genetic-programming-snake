#############################################
# Represent an individual in the popualtion.
#
include("TreeNode.jl")

struct Individual
    root::TreeNode
    fitness::Int
end
