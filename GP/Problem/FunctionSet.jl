############################################
# Function set used in Genetic Programming.
#

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

#function isFood(board::Board, param1::Function, param2::Function)
#end

function isFood(param::Int, param1::Int, param2::Int)
end

function test1(param::Int, param1::Int, param2::Int)
end

function test2(param::Int, param1::Int, param2::Int)
end
