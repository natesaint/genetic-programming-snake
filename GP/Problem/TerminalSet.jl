############################################
# Terminal set used in Genetic Programming.
#

struct TerminalSet
    terminals::Array{Function}

    TerminalSet() = new(Function[])
end

function addTerminal(ts::TerminalSet, terminal::Function)
    push!(ts.terminals, terminal)
end

function moveLeft()
end

function moveRight()
end
