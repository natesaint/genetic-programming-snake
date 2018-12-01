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

#
# Functions that can be used in the function set
#

function snakeInBlock(x::Int, y::Int)
    for sb in currBoard.snake.snake
        if sb.x == x && sb.y == y
            return true
        end
    end
    return false
end

function ifFoodAhead(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && currBoard.food.x == currBoard.snake.snake[1].x && currBoard.food.y < currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :down && currBoard.food.x == currBoard.snake.snake[1].x && currBoard.food.y > currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :left && currBoard.food.x < currBoard.snake.snake[1].x && currBoard.food.y == currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :right && currBoard.food.x > currBoard.snake.snake[1].x && currBoard.food.y == currBoard.snake.snake[1].y
        return param1
    else
        return param2
    end
end

function ifFoodBehind(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && currBoard.food.x == currBoard.snake.snake[1].x && currBoard.food.y > currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :down && currBoard.food.x == currBoard.snake.snake[1].x && currBoard.food.y < currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :left && currBoard.food.x > currBoard.snake.snake[1].x && currBoard.food.y == currBoard.snake.snake[1].y
        return param1
    elseif currBoard.move == :right && currBoard.food.x < currBoard.snake.snake[1].x && currBoard.food.y == currBoard.snake.snake[1].y
        return param1
    else
        return param2
    end
end

function ifDangerAhead(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && (currBoard.snake.snake[1].y - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y - 1))
        return param1
    elseif currBoard.move == :down && (currBoard.snake.snake[1].y + 1 >= currBoard.height + 1 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y + 1))
        return param1
    elseif currBoard.move == :left && (currBoard.snake.snake[1].x - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x - 1, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :right && (currBoard.snake.snake[1].x + 1 >= currBoard.width + 1 || snakeInBlock(currBoard.snake.snake[1].x + 1, currBoard.snake.snake[1].y))
        return param1
    else
        return param2
    end
end

function ifDangerRight(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && (currBoard.snake.snake[1].x + 1 >= currBoard.width + 1 || snakeInBlock(currBoard.snake.snake[1].x + 1, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :down && (currBoard.snake.snake[1].x - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x - 1, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :left && (currBoard.snake.snake[1].y - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y - 1))
        return param1
    elseif currBoard.move == :right && (currBoard.snake.snake[1].y + 1 >= currBoard.height + 1 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y + 1))
        return param1
    else
        return param2
    end
end

function ifDangerLeft(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && (currBoard.snake.snake[1].x - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x - 1, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :down && (currBoard.snake.snake[1].x + 1 >= currBoard.width + 1 || snakeInBlock(currBoard.snake.snake[1].x + 1, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :left && (currBoard.snake.snake[1].y + 1 >= currBoard.height + 1 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y + 1))
        return param1
    elseif currBoard.move == :right && (currBoard.snake.snake[1].y - 1 <= 0 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y - 1))
        return param1
    else
        return param2
    end
end

function ifDangerTwoAhead(param1::Symbol, param2::Symbol)
    if currBoard.move == :up && (currBoard.snake.snake[1].y - 2 <= 0 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y - 2))
        return param1
    elseif currBoard.move == :down && (currBoard.snake.snake[1].y + 2 >= currBoard.height + 1 || snakeInBlock(currBoard.snake.snake[1].x, currBoard.snake.snake[1].y + 2))
        return param1
    elseif currBoard.move == :left && (currBoard.snake.snake[1].x - 2 <= 0 || snakeInBlock(currBoard.snake.snake[1].x - 2, currBoard.snake.snake[1].y))
        return param1
    elseif currBoard.move == :right && (currBoard.snake.snake[1].x + 2 >= currBoard.width + 1 || snakeInBlock(currBoard.snake.snake[1].x + 2, currBoard.snake.snake[1].y))
        return param1
    else
        return param2
    end
end

function ifFoodUp(param1::Symbol, param2::Symbol)
    if currBoard.food.y < currBoard.snake.snake[1].y
        return param1
    else
        return param2
    end
end

# NEW
function ifFoodDown(param1::Symbol, param2::Symbol)
    if currBoard.food.y > currBoard.snake.snake[1].y
        return param1
    else
        return param2
    end
end

function ifFoodRight(param1::Symbol, param2::Symbol)
    if currBoard.food.x > currBoard.snake.snake[1].x
        return param1
    else
        return param2
    end
end

# NEW
function ifFoodLeft(param1::Symbol, param2::Symbol)
    if currBoard.food.x > currBoard.snake.snake[1].x
        return param1
    else
        return param2
    end
end

function ifMovingUp(param1::Symbol, param2::Symbol)
    if currBoard.move == :up
        return param1
    else
        return param2
    end
end

function ifMovingDown(param1::Symbol, param2::Symbol)
    if currBoard.move == :down
        return param1
    else
        return param2
    end
end

function ifMovingLeft(param1::Symbol, param2::Symbol)
    if currBoard.move == :left
        return param1
    else
        return param2
    end
end

function ifMovingRight(param1::Symbol, param2::Symbol)
    if currBoard.move == :right
        return param1
    else
        return param2
    end
end
