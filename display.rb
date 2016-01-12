require 'colorize'
require 'io/console'
require_relative 'board.rb'

class Display

  attr_reader :cursor

  def initialize(board)
    @cursor = [0, 0]
    @selected = false
    @board = board
  end

  def get_input
    STDIN.echo = false
    STDIN.raw!

    char = STDIN.getc
    case char
    when "w" || "\e[A" # up arrow
      input = [1, 0]
    when "s" || "\e[B" # down arrow
      input = [-1, 0]
    when "a" || "\e[D" # left arrow
      input = [0, -1]
    when "d" || "\e[C" # right arrow
      input = [0, 1]
    end

    STDIN.echo = true
    STDIN.cooked!

    input
  end

  def move_cursor
    input = get_input
    new_row = @cursor[0] + input[0]
    new_col = @cursor[1] + input[1]

    new_pos = [new_row, new_col]
    @cursor = new_pos if in_bounds?(new_pos)
  end

  def render_board
    # more color options https://github.com/fazibear/colorize/blob/master/lib/colorize/class_methods.rb
    (0...8).each do |row|
      (0...8).each do |col|
        piece = " " # @board[row, col].show
        if [row, col] == @cursor
          print " #{piece} ".colorize(:red).on_red
        elsif (row + col).even?
          print " #{piece} ".colorize(:light_white).on_light_white
        else
          print " #{piece} ".colorize(:light_black).light_black
        end
      end
      puts "\n"
    end
  end

  def in_bounds?(coord)
    row_in_bound = coord[0] < 8 && coord[0] >= 0
    col_in_bound = coord[1] < 8 && coord[1] >= 0

    row_in_bound && col_in_bound
  end
end
