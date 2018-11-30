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
    return "up"
end

function moveDown()
    return "down"
end

function moveLeft()
    return "left"
end

function moveRight()
    return "right"
end

# New terminal set
function forward()
    return currBoard.move
end

function turnLeft()
    if currBoard.move == "up"
        return "left"
    elseif currBoard.move == "down"
        return "right"
    elseif currBoard.move == "left"
        return "down"
    else
        return "up"
    end
end

function turnRight()
    if currBoard.move == "up"
        return "right"
    elseif currBoard.move == "down"
        return "left"
    elseif currBoard.move == "left"
        return "up"
    else
        return "down"
    end
end
