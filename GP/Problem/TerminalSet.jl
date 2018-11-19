############################################
# Terminal set used in Genetic Programming.
#

struct TerminalSet
    terminals::Array{Function}

    TerminalSet() = new(Function[])
end

# Add a terminal to the set
function addTerminal(ts::TerminalSet, terminal::Function)
    push!(ts.terminals, terminal)
end

# Choose a terminal randomly with equal probability
function chooseRand(termSet::TerminalSet)
    return termSet.terminals[rand(1:length(termSet.terminals))]
end

#
# Functions that can be used in the terminal set
#

function moveUp()
    #println("moveUp")
    #println(board)
    return "up"
end

function moveDown()
    #println("moveDown")
    #println(board)
    return "down"
end

function moveLeft()
    #println("moveLeft")
    #println(board)
    return "left"
end

function moveRight()
    #println("moveRight")
    #println(board)
    return "right"
end
