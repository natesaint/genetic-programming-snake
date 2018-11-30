###########################################################
# Tournament Selection strategy for selecting individuals.
#

struct TournamentSelection <: Selection
end

function selectIndividual(strat::TournamentSelection, pop::Population)
    first = rand(1:length(pop.members))
    second = rand(1:length(pop.members))

    if pop.fitness[first].score > pop.fitness[second].score
        return deepcopy(pop.members[first])
    elseif pop.fitness[first].score < pop.fitness[second].score
        return deepcopy(pop.members[second])
    else
        if pop.fitness[first].timeAlive > pop.fitness[second].timeAlive
            return deepcopy(pop.members[first])
        elseif pop.fitness[first].timeAlive < pop.fitness[second].timeAlive
            return deepcopy(pop.members[second])
        else
            x = rand(1:2)
            if x == 1
                return deepcopy(pop.members[first])
            else
                return deepcopy(pop.members[second])
            end
        end
    end
end
