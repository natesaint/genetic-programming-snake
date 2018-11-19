###################################
# Represent a leaf node in a tree.
#
#include("./TreeNode.jl")

struct LeafNode <: TreeNode
    func::Function

    LeafNode(f) = new(f)
end
