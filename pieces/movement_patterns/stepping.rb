module Stepping
  def valid_move?(move)
    in_bounds?(move) && board[*move].color != color
  end

  def total_moves(deltas)
    moves = []
    deltas.each do |delta|
      candidate_move = [pos[0] + delta[0], pos[1] + delta[1]]
      moves << candidate_move if valid_move?(candidate_move)
    end
    moves
  end
end
