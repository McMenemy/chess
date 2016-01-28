require_relative "piece.rb"

class Board
  attr_accessor :board
  
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

  def move(start, end_pos)
    start_piece = self[*start]
    raise NullPieceError if start_piece.is_a?(NullPiece)
    raise InvalidMoveError if !(start_piece.possible_moves.include?(end_pos))
    start_piece.pos = end_pos
    self[*end_pos] = start_piece
    self[*start] = NullPiece.new([*start], self)
  end
  
  def king_pos(color)
    each_tile do |row, col|
      piece = self[row, col]
      return [row, col] if piece.is_a?(King) && piece.color == color
    end
  end
  
  def in_check?(color)
    king_pos = king_pos(color)
    
    each_tile do |row, col|
      piece = self[row, col]
      if piece.other_color?(color)
        return true if piece.possible_moves.include?(king_pos)
      end 
    end
    false
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
