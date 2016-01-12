include 'perpendicular.rb'

class Rook
  def initialize(pos, color, board)
    super(pos, color, board)
    @show = "♖"
  end

  # make sure move is valid then call move in board class
  def move(new_pos)
    if valid?(new_pos)
      pos = new_pos
      board.move(pos, new_pos)
    end
  end

  def valid?(new_pos)
    moves = perpendicular_moves(pos)
    pieces = []
    moves.each do |possible_pos|
      pieces << possible_pos unless board[possible_pos].is_a?(NullPiece)
    end


    nearest_blocked_row_above = 7
    nearest_blocked_row_below = 0
    nearest_blocked_col_left = 0
    nearest_blocked_col_right = 7

    pieces.each do |blocked_pos|
      blocked_row = blocked_pos[0]
      blocked_col = blocked_pos[1]

      if blocked_row > pos[0] && blocked_row < nearest_blocked_row_above
        nearest_blocked_row_above = blocked_row
      elsif blocked_row < pos[0] && blocked_row > nearest_blocked_row_below
        nearest_blocked_row_below = blocked_row
      elsif blocked_col > pos[1] && blocked_col < nearest_blocked_col_right
        nearest_blocked_col_right = blocked_col
      elsif blocked_col < pos[1] && blocked_col 
      end


      nearest_blocked_row_below =
    end


    moves.reject do |possible_pos|

    end
  end
end
