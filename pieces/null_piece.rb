class NullPiece < Piece
  def initialize(pos, board, color = :blue)
    super(pos, board, color)
    @show = " "
  end
end
