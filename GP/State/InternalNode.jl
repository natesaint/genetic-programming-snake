########################################
# Represent an internal node in a tree.
#

struct InternalNode <: TreeNode
    children::Array{TreeNode}
    func::Function

    InternalNode(f) = new(TreeNode[], f)
end
