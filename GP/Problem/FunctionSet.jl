############################################
# Function set used in Genetic Programming.
#
#include("../../Snake/model/Board.jl")

struct FunctionSet
    functions::Array{Function}

    FunctionSet() = new(Function[])
end

# Add a function to the set
function addFunction(fs::FunctionSet, func::Function)
    push!(fs.functions, func)
end

# Choose a function randomly with equal probability
function chooseRand(funcSet::FunctionSet)
    return funcSet.functions[rand(1:length(funcSet.functions))]
end

#
# Functions that can be used in the function set
#

function connector(board::Board, param1::String, param2::String)
    return "connector"
end

function ifFoodAhead(board::Board, param1::String, param2::String)
    return "ifFoodAhead"
end

function ifDangerAhead(board::Board, param1::String, param2::String)
    return "ifDangerAhead"
end

function ifDangerRight(board::Board, param1::String, param2::String)
    return "ifDangerRight"
end

function ifDangerLeft(board::Board, param1::String, param2::String)
    return "ifDangerLeft"
end

function ifDangerTwoAhead(board::Board, param1::String, param2::String)
    return "ifDangerTwoAhead"
end

function ifFoodUp(board::Board, param1::String, param2::String)
    return "ifFoodUp"
end

function ifFoodRight(board::Board, param1::String, param2::String)
    return "ifFoodRight"
end

function ifMovingUp(board::Board, param1::String, param2::String)
    if board.move == "up"
        return param1
    else
        return param2
    end
end

function ifMovingDown(board::Board, param1::String, param2::String)
    if board.move == "down"
        return param1
    else
        return param2
    end
end

function ifMovingLeft(board::Board, param1::String, param2::String)
    if board.move == "left"
        return param1
    else
        return param2
    end
end

function ifMovingRight(board::Board, param1::String, param2::String)
    if board.move == "right"
        return param1
    else
        return param2
    end
end
