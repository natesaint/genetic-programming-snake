########################################
# Represent a node in a tree structure.
#
include("../../Snake/model/Board.jl")

abstract type TreeNode end

# Recursively, parse the tree into a function structure(as string) that can be called
function parseTreeStr(node::TreeNode)
    str = string("", node.func, "(")

    if typeof(node) == InternalNode
        str = string(str, "currBoard, ")
        i = 1
        for n in node.children
            #str = string(str, "string(")
            str = string(str, parseTreeStr(n))
            #str = string(str, ")")
            if i != length(node.children)
                str = string(str, ", ")
            end
            i = i + 1
        end
    else
        str = string(str, "currBoard")
    end

    str = string(str, ")")

    return str
end

# Visualize tree recursively
function visualizeTree(node::TreeNode, depth::Int)
    for i in 1:depth
        print("   ")
    end

    println(string(node.func))

    if typeof(node) == InternalNode
        for n in node.children
            visualizeTree(n, depth + 1)
        end
    end
end

# Recursively, evaluate the tree updating b(Board) with whatever results necessary
function evalTree(node::TreeNode, b::Board)
    if typeof(node) == LeafNode
        node.func(b)
    end

    node.func(b, parseTreeFunc(node.children[1], b), parseTreeFunc(node.children[2], b))
end
