require_relative 'movement_patterns/stepping.rb'

class Knight < Piece
  include Stepping

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♞' : @show = '♘'
  end

  def possible_moves
      deltas = [
                [1, 2],
                [2, 1],
                [-2, 1],
                [2, -1],
                [-1, 2],
                [-1, -2],
                [-2, -1],
                [1, -2]
              ]
              
    total_moves(deltas)
  end
end
