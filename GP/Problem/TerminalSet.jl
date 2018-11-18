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

function moveUp(board::Board)
    println("moveUp")
    println(board)
    board.move = "hi"
end

function moveDown(board::Board)
    println("moveDown")
    println(board)
    board.move = "hi"
end

function moveLeft(board::Board)
    println("moveLeft")
    println(board)
    board.move = "hi"
end

function moveRight(board::Board)
    println("moveRight")
    println(board)
    board.move = "hi"
end
