class Piece
  attr_accessor :pos, :board
  attr_reader :color, :show

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @show = nil
  end

end
