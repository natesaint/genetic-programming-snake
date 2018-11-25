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
    indivOne = selectIndividual(system.selectionStrategy, state.currPopulation)
    indivTwo = selectIndividual(system.selectionStrategy, state.currPopulation)

    #println("indiv selected")

    if indivOne.numNodes < 2 || indivTwo.numNodes < 2
        return
    end

    #println("comparison happened")

    x = Count(0)
    y = Count(0)
    countNodes(indivOne.root, x) # GETTING A SEGFAULT IN countNodes
    countNodes(indivTwo.root, y)
    countOne = x.count
    countTwo = y.count

    #println("counted nodes")

    # Select random node that isn't the first one in each tree
    posOne = rand(2:countOne)#indivOne.numNodes)
    posTwo = rand(2:countTwo)
    foundOne = Found(InternalNode(moveUp))## THIS IS WHERE THE NODE WITHOUT ARGS IS BEING ADDED. I THINK THE COUNT FUNCTION IS WRONG
    foundTwo = Found(InternalNode(moveUp))
    getNodeAt(indivOne.root, posOne, Count(0), foundOne)
    getNodeAt(indivTwo.root, posTwo, Count(0), foundTwo)

    #println("NEWMAN+++++++++++++++++++++++++")
    #println(countOne)
    #visualizeTree(indivOne.root, 0)
    #println(posOne)
    #visualizeTree(foundOne.node, 0)
    #println()

    #println(countTwo)
    #visualizeTree(indivTwo.root, 0)
    #println(posTwo)
    #visualizeTree(foundTwo.node, 0)
    #println()

    # Swap the branches that were selected
    newIndivOne = deepcopy(indivOne)
    newIndivTwo = deepcopy(indivTwo)
    arrOne = TreeNode[]
    arrTwo = TreeNode[]
    convertTree(newIndivOne.root, arrOne)
    convertTree(newIndivTwo.root, arrTwo)
    #println("Testing array")
    #println(length(arrOne))
    #println(arrOne)
    #visualizeTree(newIndivOne.root, 0)
    #println(posOne)
    #visualizeTree(foundTwo.node, 0)
    #println()
    #println("Before first insert")
    #insertBranch(newIndivOne.root, foundTwo.node, posOne, Count(1))
    rootOne = insertBranch(arrOne, foundTwo.node, posOne)
    rootTwo = insertBranch(arrTwo, foundOne.node, posTwo)
    newIndivOne.root = rootOne
    newIndivTwo.root = rootTwo
    #println(rootOne)
    #visualizeTree(rootOne, 0)

    #println("After first insert")
    #visualizeTree(newIndivOne.root, 0)
    #println()
    #indivOne.root.children[0]
    #println("Before second insert")
    #visualizeTree(newIndivTwo.root, 0)

    #insertBranch(newIndivTwo.root, foundOne.node, posTwo, Count(1))

    #println("After second insert")

    #visualizeTree(newIndivOne.root, 0)
    #println()
    #visualizeTree(newIndivTwo.root, 0)
    #println()
    #indivOne.root.children[0]

    #######visualizeTree(newIndivOne.root, 0)
    #######println()
    #######visualizeTree(newIndivTwo.root, 0)
    #######println()

    #println("before insert")
    #println(getNumIndividuals(newPop))
    addIndividual(newPop, newIndivOne)
    addIndividual(newPop, newIndivTwo)
    #println(getNumIndividuals(newPop))
    #println("after insert")
end

# Convert a branch to an array representation
function convertTree(node::TreeNode, arr::Array{TreeNode})
    if typeof(node) == InternalNode
        push!(arr, InternalNode(node.func))
    else
        push!(arr, LeafNode(node.func))
    end

    if typeof(node) == InternalNode
        for n in node.children
            convertTree(n, arr)
        end
    end
end

# Insert a new branch into an individual at a desired position
function insertBranch(arr::Array{TreeNode}, newBranch::TreeNode, target::Int)#node::TreeNode, newBranch::TreeNode, target::Int, cnt::Count)
    # Run through the array backwards and create the new tree
    i = length(arr)
    while i > 0
        if typeof(arr[i]) == InternalNode# && i != target
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

                # Set the array at the index to the new node
                #println("Array[target]")
                #println(target)
                #println(arr[target])
                arr[target] = newBranch
                #println("Array[target] new branch")
                #println(arr[target])
            else
                #println("i FOUND")
                #println(i)
                k = 0

                # Add the children
                j = i
                while k < numArgs
                    j = j + 1
                    toAdd = deepcopy(arr[j])
                    push!(arr[i].children, toAdd)
                    k = k + 1
                end

                # Remove the children that were added from the array
                k = 0
                while k < numArgs
                    deleteat!(arr, i + 1)
                    k = k + 1
                end
            end
        end
        i = i - 1
    end

    #println("SIZE OF ARRAY")
    #println(length(arr))

    return arr[1]
end

# Get the node at a position in a tree
function getNodeAt(node::TreeNode, target::Int, cnt::Count, found::Found)
    cnt.count = cnt.count + 1

    if cnt.count > target
        return
    end

    if cnt.count == target
        found.node = node
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
