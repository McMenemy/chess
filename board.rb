class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    # populate
  end

  def populate
    @board.each do |row|
      row.each do |col|
        @board[row, col] = Piece.new
      end
    end
  end

  def move(start, end_pos)
    if @board[*start].nil? || !@board[*start].valid_move?(end_pos)
      raise Exception
    end
    @board[*end_pos] = @board[*start]
    @board[*start] = nil # make null piece
    @board[*end_pos].position = end_pos
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, piece)
    @board[row, col] = piece
  end
end
