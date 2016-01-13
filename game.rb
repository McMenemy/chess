require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @current_player = @player1
  end

  def play

  end

  def take_turn(player1)
    until @display.selected
      @display.move_cursor
      system("clear")
      @display.render_board
    end

    start_pos = @display.cursor
    puts "piece at #{start_pos} selected"

    while @display.selected
      @display.move_cursor
      system("clear")
      @display.render_board
    end

    end_pos = @display.cursor
    @board.move(start_pos, end_pos)
  end

end
