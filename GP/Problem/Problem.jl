############################################
# Represent the specific problem that GP is
# being used to handle.
#

struct Problem
    eval::FitnessEval
    functionSet::FunctionSet
    terminalSet::TerminalSet
    terminationCriterion::Function

    Problem(fitnessFunc, terminationFunc, numRunsPerTest) = new(FitnessEval(fitnessFunc, numRunsPerTest), FunctionSet(), TerminalSet(), terminationFunc)
end
