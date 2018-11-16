############################################
# Function set used in Genetic Programming.
#

struct FunctionSet
    functions::Array{Function}

    FunctionSet() = new(Function[])
end

function addFunction(fs::FunctionSet, func::Function)
    push!(fs.functions, func)
end

function isFood()
end
