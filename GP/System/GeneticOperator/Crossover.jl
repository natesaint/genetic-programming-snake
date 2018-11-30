##########################################
# The crossover genetic operation used in
# genetic programming.
#

struct Crossover <: GeneticOperator
    probability::Float64
end

# Genetic programming crossover genetic operator
function geneticOperation(c::Crossover, state::State, system::System, newPop::Population)
    #println("Performing crossover")
    # Select two individuals
    indivOne = deepcopy(selectIndividual(system.selectionStrategy, state.currPopulation))
    indivTwo = deepcopy(selectIndividual(system.selectionStrategy, state.currPopulation))

    #println("Indiv ONE")
    #printIndividual(indivOne)
    #println("Indiv TWO")
    #printIndividual(indivTwo)

    if indivOne.numNodes < 2 || indivTwo.numNodes < 2
        return
    end

    x = Count(0)
    y = Count(0)
    countNodes(indivOne.root, x)
    countNodes(indivTwo.root, y)
    countOne = x.count
    countTwo = y.count

    # Select random node that isn't the first one in each tree
    posOne = rand(2:countOne)
    posTwo = rand(2:countTwo)
    foundOne = Found(InternalNode(moveUp))
    foundTwo = Found(InternalNode(moveUp))
    getNodeAt(indivOne.root, posOne, Count(0), foundOne)
    getNodeAt(indivTwo.root, posTwo, Count(0), foundTwo)

    #print("\n\nPOS ONE")
    #println(posOne)
    #print("POS TWO")
    #println(posTwo)
    #println("\nFOUND ONE")
    #visualizeTree(foundOne.node, 0)
    #println("FOUND TWO")
    #visualizeTree(foundTwo.node, 0)

    # Swap the branches that were selected
    newIndivOne = deepcopy(indivOne)
    newIndivTwo = deepcopy(indivTwo)
    arrOne = TreeNode[]
    arrTwo = TreeNode[]
    convertTree(newIndivOne.root, arrOne)
    convertTree(newIndivTwo.root, arrTwo)

    # Insert new branches
    rootOne = deepcopy(insertBranch(arrOne, foundTwo.node, posOne))
    rootTwo = deepcopy(insertBranch(arrTwo, foundOne.node, posTwo))
    newIndivOne.root = deepcopy(rootOne)
    newIndivTwo.root = deepcopy(rootTwo)

    #println("\nROOT ONE") # THE CROSSOVER SWAP DOESN"T WORK AT ALL WHEN THE SELECTED ELEMENT IS AN INTERNAL NODE
    #visualizeTree(newIndivOne.root, 0)
    #println("ROOT TWO")
    #visualizeTree(newIndivTwo.root, 0)

    # Check if it is at the limit
    x = getDepth(newIndivOne.root)
    y = getDepth(newIndivTwo.root)

    #println("NEW DEPTHS")
    #println(x)
    #println(y)

    if x > 5 || y > 5
        return
    end

    #println("before insert")
    #println(getNumIndividuals(newPop))
    #for indivi in newPop.members
    #    printIndividual(indivi)
    #end
    addIndividual(newPop, deepcopy(newIndivOne))
    addIndividual(newPop, deepcopy(newIndivTwo))
    #println("after insert")
    #println(getNumIndividuals(newPop))
    #for indivi in newPop.members
    #    printIndividual(indivi)
    #end
end

# Get the depth of a tree
function getDepth(node::TreeNode)
    if typeof(node) == InternalNode
        leftDepth = getDepth(node.children[1])
        rightDepth = getDepth(node.children[2])

        if leftDepth > rightDepth
            return leftDepth + 1
        else
            return rightDepth + 1
        end
    else
        return 1
    end
end

# Convert a branch to an array representation
function convertTree(node::TreeNode, arr::Array{TreeNode})
    if typeof(node) == InternalNode
        push!(arr, deepcopy(InternalNode(node.func)))
    else
        push!(arr, deepcopy(LeafNode(node.func)))
    end

    if typeof(node) == InternalNode
        for n in node.children
            convertTree(n, arr)
        end
    end
end

# Insert a new branch into an individual at a desired position
function insertBranch(arr::Array{TreeNode}, newBranch::TreeNode, target::Int)
    # Run through the array backwards and create the new tree
    i = length(arr)
    while i > 0
        #println(i)
        #printArray(arr)

        if typeof(arr[i]) == InternalNode
            numArgs = 0
            for m in methods(arr[i].func)
                numArgs = length(m.sig.parameters) - 1
            end

            # If i is equal to target, delete everything under that node and replace it with new node
            if i == target
                k = 0
                while k < numArgs
                    deleteat!(arr, i + 1)
                    k = k + 1
                end

                arr[target] = deepcopy(newBranch)
            else
                k = 0

                # Add the children
                j = i
                while k < numArgs
                    j = j + 1
                    toAdd = deepcopy(arr[j])
                    push!(arr[i].children, deepcopy(toAdd))
                    k = k + 1
                end

                # Remove the children that were added from the array
                k = 0
                while k < numArgs
                    deleteat!(arr, i + 1)
                    k = k + 1
                end
            end
        else
            if i == target
                arr[target] = deepcopy(newBranch)
            end
        end
        i = i - 1
    end

    return arr[1]
end

# print the array for debug purposes
function printArray(arr::Array{TreeNode})
    for i in arr
        println(i.func)
    end
end

# Get the node at a position in a tree
function getNodeAt(node::TreeNode, target::Int, cnt::Count, found::Found)
    cnt.count = cnt.count + 1

    if cnt.count > target
        return
    end

    if cnt.count == target
        found.node = deepcopy(node)
        return
    end

    if typeof(node) == InternalNode
        for n in node.children
            getNodeAt(n, target, cnt, found)
        end
    end
end

# Count nodes in tree
function countNodes(node::TreeNode, cnt::Count)
    cnt.count = cnt.count + 1
    if typeof(node) == InternalNode
        for n in node.children
            countNodes(n, cnt)
        end
    end
end
