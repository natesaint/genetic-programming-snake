###################################################
# Make it easy to count number of nodes in a tree.
#

mutable struct Count
    count::Int
end

# Useful for finding nodes in a tree
mutable struct Found
    node::TreeNode
end
