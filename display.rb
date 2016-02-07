require 'colorize'
require 'io/console'
require_relative 'board.rb'

class Display
  attr_accessor :board, :cursor 

  def initialize(board)
    @cursor = [0, 0]
    @board = board
  end

  def get_input
    STDIN.iflush
    STDIN.echo = false
    STDIN.raw!

    char = STDIN.getc
    if char == "w"
      input = [-1, 0]
    elsif char == "s"
      input = [1, 0]
    elsif char == "a"
      input = [0, -1]
    elsif char == "d"
      input = [0, 1]
    elsif char == 'q'
      input = 'selected'
    elsif char == 'e'
      input = 'exit program'
    else
      input = 'try again'
    end

    STDIN.echo = true
    STDIN.cooked!

    input
  end

  def move_cursor(input)
    new_row = wrap_cursor(self.cursor[0] + input[0])
    new_col = wrap_cursor(self.cursor[1] + input[1])
    self.cursor = [new_row, new_col]
  end
  
  def wrap_cursor(row_col) # works in pry
    if row_col > 7
      return row_col - 8
    elsif row_col < 0
      return row_col + 8
    else
      return row_col
    end
  end
  
  def render_board
    # more color options https://github.com/fazibear/colorize/blob/master/lib/colorize/class_methods.rb
    (0...8).each do |row|
      (0...8).each do |col|
        piece = self.board[row, col]
        if [row, col] == self.cursor
          print "#{piece.show}".colorize(piece.color).on_red
        elsif (row + col).even? && piece
          print "#{piece.show}".colorize(piece.color).on_light_green
        else
          print "#{piece.show}".colorize(piece.color).on_blue
        end
      end
      puts "\n"
    end
  end

end
