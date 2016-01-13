class Piece
  attr_accessor :pos, :board
  attr_reader :color, :show

  def initialize(pos, board, color)
    @pos = pos
    @color = color
    @board = board
    @show = nil
  end

  def move(new_pos)
    if valid_move?(new_pos)
      pos = new_pos
      board.move(pos, new_pos)
    end
  end

  def valid_move?
  end

  def inspect
    "#{self.class} #{pos.inspect}" #.colorize(color)
  end

  def other_color?(other_color)
    return true if color == :black && other_color == :white
    return true if color == :white && other_color == :black
    false
  end

  def in_bounds?(coordinate)
    @board.in_bounds?(coordinate)
  end
end

require_relative "pieces/bishop.rb"
require_relative "pieces/king.rb"
require_relative "pieces/knight.rb"
require_relative "pieces/null_piece.rb"
require_relative "pieces/pawn.rb"
require_relative "pieces/queen.rb"
require_relative "pieces/rook.rb"
