###################################
# Represent a leaf node in a tree.
#

struct LeafNode <: TreeNode
    func::Function

    LeafNode(f) = new(f)
end
