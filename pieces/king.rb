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
  
    possible_moves_exluding_check = total_moves(deltas)
    # safe_moves = []
    
    # possible_moves_exluding_check.each do |move|
    #   safe_moves << move unless self.board.in_check?(self.color, move)
    # end
    
    # safe_moves
  end
  
end
