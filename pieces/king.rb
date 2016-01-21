require_relative 'movement_patterns/stepping.rb'

class King < Piece
  include Stepping

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♚' : @show = '♔'
  end

  def possible_moves
    deltas = [
              [1, 1],
              [1, 0],
              [1, -1],
              [0, 1],
              [0, -1],
              [-1, 1],
              [-1, -1],
              [-1, 0]
            ]
  
    total_moves(deltas)
  end
end
