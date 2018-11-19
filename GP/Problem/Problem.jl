############################################
# Represent the specific problem that GP is
# being used to handle.
#
#include("./FitnessEval.jl")
#include("./FunctionSet.jl")
#include("./TerminalSet.jl")

struct Problem
    eval::FitnessEval
    functionSet::FunctionSet
    terminalSet::TerminalSet
    terminationCriterion::Function

    Problem(fitnessFunc, terminationFunc, numRunsPerTest) = new(FitnessEval(fitnessFunc, numRunsPerTest), FunctionSet(), TerminalSet(), terminationFunc)
end
