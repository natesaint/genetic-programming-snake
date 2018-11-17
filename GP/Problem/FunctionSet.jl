############################################
# Function set used in Genetic Programming.
#
include("../../Snake/model/Board.jl")

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

function connector(board::Board, param1::Function, param2::Function)
end

function ifFoodAhead(board::Board, param1::Function, param2::Function)
end

function ifDangerAhead(board::Board, param1::Function, param2::Function)
end

function ifDangerRight(board::Board, param1::Function, param2::Function)
end

function ifDangerLeft(board::Board, param1::Function, param2::Function)
end

function ifDangerLeft(board::Board, param1::Function, param2::Function)
end

function ifDangerTwoAhead(board::Board, param1::Function, param2::Function)
end

function ifFoodUp(board::Board, param1::Function, param2::Function)
end

function ifFoodRight(board::Board, param1::Function, param2::Function)
end

function ifMovingUp(board::Board, param1::Function, param2::Function)
end

function ifMovingDown(board::Board, param1::Function, param2::Function)
end

function ifMovingLeft(board::Board, param1::Function, param2::Function)
end

function ifMovingRight(board::Board, param1::Function, param2::Function)
end
