require 'colorize'
require 'io/console'
require_relative 'board.rb'

class Display
  attr_accessor :selected
  attr_reader :cursor

  def initialize(board)
    @cursor = [0, 0]
    @selected = false
    @board = board
  end

  def get_input
    STDIN.iflush
    STDIN.echo = false
    STDIN.raw!

    char = STDIN.getc
    case char
    when "w" || "\e[A" # up arrow
      input = [-1, 0]
      p input
    when "s" || "\e[B" # down arrow
      input = [1, 0]
    when "a" || "\e[D" # left arrow
      input = [0, -1]
    when "d" || "\e[C" # right arrow
      input = [0, 1]
    when 'q'
      input = 'selected'

    end

    STDIN.echo = true
    STDIN.cooked!

    input
  end

  def move_cursor
    input = get_input
    if input == 'selected'
      @selected = !@selected
      return @cursor
    end
    new_row = @cursor[0] + input[0]
    new_col = @cursor[1] + input[1]

    new_pos = [new_row, new_col]
    @cursor = new_pos if in_bounds?(new_pos)
  end

  def render_board
    # more color options https://github.com/fazibear/colorize/blob/master/lib/colorize/class_methods.rb
    (0...8).each do |row|
      (0...8).each do |col|
        piece = @board[row, col]
        if [row, col] == @cursor
          print "#{piece.show} ".colorize(piece.color).on_red
        elsif (row + col).even? && piece
          print "#{piece.show} ".colorize(piece.color).on_light_green
        else
          print "#{piece.show} ".colorize(piece.color).on_blue
        end
      end
      puts "\n"
    end
  end

  def in_bounds?(coordinate)
    @board.in_bounds?(coordinate)
  end
end
