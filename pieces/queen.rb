require_relative 'movement_patterns/sliding.rb'

class Queen < Piece
  include Sliding

  def initialize(pos, board, color)
    super(pos, board, color)
    color == :black ? @show = '♛' : @show = '♕'
  end

  def possible_moves
    perpendicular_moves(pos) + diagonal_moves(pos)
  end
end
