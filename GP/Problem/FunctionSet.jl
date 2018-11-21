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

function ifFoodAhead(param1::String, param2::String)
    return "ifFoodAhead"
end

function ifDangerAhead(param1::String, param2::String)
    return "ifDangerAhead"
end

function ifDangerRight(param1::String, param2::String)
    return "ifDangerRight"
end

function ifDangerLeft(param1::String, param2::String)
    return "ifDangerLeft"
end

function ifDangerTwoAhead(param1::String, param2::String)
    return "ifDangerTwoAhead"
end

function ifFoodUp(param1::String, param2::String)
    return "ifFoodUp"
end

function ifFoodRight(param1::String, param2::String)
    return "ifFoodRight"
end

function ifMovingUp(param1::String, param2::String)
    if currBoard.move == "up"
        return param1
    else
        return param2
    end
end

function ifMovingDown(param1::String, param2::String)
    if currBoard.move == "down"
        return param1
    else
        return param2
    end
end

function ifMovingLeft(param1::String, param2::String)
    if currBoard.move == "left"
        return param1
    else
        return param2
    end
end

function ifMovingRight(param1::String, param2::String)
    if currBoard.move == "right"
        return param1
    else
        return param2
    end
end
