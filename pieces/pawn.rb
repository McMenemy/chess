class Pawn < Piece
  attr_accessor :deltas

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♟' : @show = '♙'
    if color == :black
      @deltas = [
        [1, 0],
        [1, 1],
        [1, -1],
        [2, 0]
      ]
    else
      @deltas = [
        [-1, 0],
        [-1, 1],
        [-1, -1],
        [-2, 0]
      ]
    end
  end

  def possible_moves
    moves = []
    deltas.each do |move|
      moves << [pos[0] + move[0], pos[1] + move[1]] if valid_move?(move)
    end
    moves
  end

  def valid_move?(move)
    new_pos = [pos[0] + move[0], pos[1] + move[1]]
    return true if move == deltas[0] && board[*new_pos].is_a?(NullPiece)
    return true if can_move_two?(move, new_pos)
    if in_bounds?(new_pos) && (move == deltas[2] || move == deltas[1])
      return true if other_color?(board[*new_pos].color)
    end
    false
  end

  def can_move_two?(move, new_pos)
    move == deltas[3] && valid_move?(deltas[0]) &&
      board[*new_pos].is_a?(NullPiece) && (pos[0] == 1 || pos[0] == 6)
  end
end
