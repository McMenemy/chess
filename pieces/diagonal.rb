module Diagonal
  def diagonal_moves(pos)
    start_row = pos[0]
    start_col = pos[1]
    moves = [pos]

    i = 0
    until moves.last.first >= 7 || moves.last.last >= 7
      i += 1
      moves << [start_row + i, start_col + i]
    end

    i = 0
    until moves.last.first <= 0 || moves.last.last <= 0
      i += 1
      moves << [start_row - i, start_col - i]
    end

    i = 0
    loop do
      i += 1
      moves << [start_row - i, start_col + i]
      break if moves.last.last >= 7 || moves.last.first <= 0
    end

    i = 0
    loop do
      i += 1
      moves << [start_row + i, start_col - i]
      break if moves.last.last <= 0 || moves.last.first >= 7
    end

    moves.drop(1)
  end
end
