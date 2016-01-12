module Perpendicular
  def perpendicular_moves(pos)
    start_row = pos[0]
    start_col = pos[1]
    moves = [pos]

    i = 0
    until moves.last.first >= 7
      i += 1
      moves << [start_row + i, start_col]
    end

    i = 0
    until moves.last.first <= 0
      i += 1
      moves << [start_row - i, start_col]
    end

    i = 0
    until moves.last.last >= 7
      i += 1
      moves << [start_row, start_col + i]
    end

    i = 0
    until moves.last.last <= 0
      i += 1
      moves << [start_row, start_col - i]
    end

    moves.drop(1)
  end
end
