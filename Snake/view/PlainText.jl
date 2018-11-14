#####################################################
# Plain text view of Snake - the game gets displayed
# using stdout.
#

##################################################
# Output the plain text view, storing elements of
# the game board in a Char array and printing it.
#
function outputPlainText(board::Board)
	boardOutput = []

	# Default board (edges and floor)
	for i = 1:board.height + 2
		if i == 1 || i == board.height + 2
			row = []
			for j = 1:board.width + 2
				push!(row, "#")
			end
			push!(boardOutput, row)
		else
			row = []
			push!(row, "#")
			for j = 1:board.width
				push!(row, ".")
			end
			push!(row, "#")
			push!(boardOutput, row)
		end
	end

	# Add Snake
	for row in board.snake.snake
		boardOutput[row.x][row.y] = "O"
	end

	# Add Food
	boardOutput[board.food.x][board.food.y] = "*"

	printArray(boardOutput, board.width + 2, board.height + 2)
end

####################
# Print a 2-D array
#
function printArray(array::Array{Any, 1}, n::Int, m::Int)
	for i = 1:n
		for j = 1:m
			print(array[i][j])
		end
		println()
	end
end
