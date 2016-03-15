require_relative "piece.rb"

class Board
  attr_accessor :board, :test_board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    each_tile do |row, col|
      tile = [row, col]
      if tile == [0, 1] || tile == [0, 6]
        self[*tile] = Knight.new(tile, self, :black)
      elsif tile == [7, 1] || tile == [7, 6]
        self[*tile] = Knight.new(tile, self, :white)
      elsif tile == [0, 4]
        self[*tile] = King.new(tile, self, :black)
      elsif tile == [7, 4]
        self[*tile] = King.new(tile, self, :white)
      elsif tile == [0, 0] || tile == [0, 7]
        self[*tile] = Rook.new(tile, self, :black)
      elsif tile == [7, 0] || tile == [7, 7]
        self[*tile] = Rook.new(tile, self, :white)
      elsif tile == [0, 2] || tile == [0, 5]
        self[*tile] = Bishop.new(tile, self, :black)
      elsif tile == [7, 2] || tile == [7, 5]
        self[*tile] = Bishop.new(tile, self, :white)
      elsif tile == [0, 3]
        self[*tile] = Queen.new(tile, self, :black)
      elsif tile == [7, 3]
        self[*tile] = Queen.new(tile, self, :white)
      elsif row == 1
        self[*tile] = Pawn.new(tile, self, :black)
      elsif row == 6
        self[*tile] = Pawn.new(tile, self, :white)
      else
        self[*tile] = NullPiece.new(tile, self)
      end
    end
  end

  def each_tile
    8.times do |row|
      8.times do |col|
        yield(row, col)
      end
    end
  end

  def move(start_pos, end_pos)
    start_piece = self[*start_pos]

    unless valid_move?(start_piece, end_pos)
      return 'invalid move'
    end

    start_piece.pos = end_pos
    self[*end_pos] = start_piece
    self[*start_pos] = NullPiece.new([*start_pos], self)
  end

  def in_check_after?(start_pos, end_pos)
    color = self[*start_pos].color
    @test_board = self.dup
    @test_board.move(start_pos, end_pos)
    test_board.in_check?(color)
  end

  def valid_move?(start_piece, end_pos)
    start_piece.possible_moves.include?(end_pos)
  end

  def king_pos(color)
    each_tile do |row, col|
      piece = self[row, col]
      return [row, col] if piece.is_a?(King) && piece.color == color
    end
  end

  def in_check?(color, king_pos = nil)
    king_pos ||= king_pos(color)

    each_tile do |row, col|
      piece = self[row, col]
      if piece.pos != king_pos && piece.other_color?(color)
        return true if piece.possible_moves.include?(king_pos)
      end
    end
    false
  end

  def check_mate?(color)
    self.each_tile do |row, col|
      pos = [row, col]
      piece = self[*pos]
      return false if (piece.color == color && prevent_check?(piece, pos, color))
    end

    true
  end

  def prevent_check?(piece, start_pos, color)
    piece.possible_moves.each do |end_move|
      @test_board = self.dup
      @test_board.move(start_pos, end_move)
      unless test_board.in_check?(color)
        return true
      end
    end

    false
  end

  def dup
    temp_board = Board.new

    self.each_tile do |row, col|
      piece = self[row, col]
      new_piece = piece.class.new(piece.pos, temp_board, piece.color)
      temp_board[row, col] = new_piece
    end

    temp_board
  end

  def in_bounds?(coord)
    row_in_bound = coord[0] < 8 && coord[0] >= 0
    col_in_bound = coord[1] < 8 && coord[1] >= 0

    row_in_bound && col_in_bound
  end

  def [](row, col)
    self.board[row][col]
  end

  def []=(row, col, piece)
    self.board[row][col] = piece
  end


end
