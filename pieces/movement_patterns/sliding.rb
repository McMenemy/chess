module Sliding
  def perpendicular_moves(pos)
    new_pos = [pos[0] - 1, pos[1] + 0]
    up_moves = directional_moves(new_pos, [-1, 0])
    new_pos = [pos[0] + 1, pos[1] + 0]
    down_moves = directional_moves(new_pos, [1, 0])
    new_pos = [pos[0] + 0, pos[1] - 1]
    left_moves = directional_moves(new_pos, [0, -1])
    new_pos = [pos[0] + 0, pos[1] + 1]
    right_moves = directional_moves(new_pos, [0, 1])

    right_moves + down_moves + left_moves + up_moves
  end

  def diagonal_moves(pos)
    new_pos = [pos[0] - 1, pos[1] + 1]
    up_right_moves = directional_moves(new_pos, [-1, 1])
    new_pos = [pos[0] + 1, pos[1] + 1]
    down_right_moves = directional_moves(new_pos, [1, 1])
    new_pos = [pos[0] + 1, pos[1] - 1]
    down_left_moves = directional_moves(new_pos, [1, -1])
    new_pos = [pos[0] - 1, pos[1] - 1]
    up_left_moves = directional_moves(new_pos, [-1, -1])

    up_left_moves + down_right_moves + down_left_moves + up_right_moves
  end

  def directional_moves(pos, direction)
    return [] unless in_bounds?(pos)
    return [] if board[*pos].color == color
    return [pos] if other_color?(board[*pos].color)

    row = pos[0] + direction[0]
    col = pos[1] + direction[1]
    new_pos = [row, col]
    [pos] + directional_moves(new_pos, direction)
  end
end
