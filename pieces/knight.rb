require_relative 'movement_patterns/stepping.rb'

class Knight < Piece
  include Stepping

  DELTAS = [
    [1, 2],
    [2, 1],
    [-2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [-2, -1],
    [1, -2]
  ]

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♞' : @show = '♘'
  end

  def possible_moves
    total_moves(DELTAS)
  end
end
