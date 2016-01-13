require_relative 'movement_patterns/stepping.rb'

class King < Piece
  include Stepping

  DELTAS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, -1],
    [-1, 0]
  ]

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♚' : @show = '♔'
  end

  def possible_moves
    total_moves(DELTAS)
  end
end
