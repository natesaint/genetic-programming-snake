###########################################################
# Functions that can be used as the termination criterion.
#

# Check score against the maximum possible score for the given baord of size
# sizeX by sizeY
function isMaxScoreRectangleBoard(score::Int, sizeX::Int, sizeY::Int)
    return score == sizeX * sizeY
end
