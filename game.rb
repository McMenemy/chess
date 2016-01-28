require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  attr_reader :player1, :player2, :board, :display
  attr_accessor :current_player, :turn_count

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @current_player = @player1
    @turn_count = 0 # temp variable for testing
    
    play
  end

  def play
    until game_over?
      take_turn(self.current_player)
      switch_player
      p "in check?: #{self.board.in_check?(:white)}"
      self.turn_count += 1
    end
    p 'game over'
  end
  
  def game_over?
    self.turn_count > 5 ? true : false
  end
  
  def switch_player
    if self.current_player == self.player1 
      self.current_player = self.player2
    else
      self.current_player = self.player1
    end
  end

  def take_turn(player1)
    until self.display.selected
      self.display.move_cursor
      system("clear")
      self.display.render_board
    end

    start_pos = self.display.cursor
    puts "piece at #{start_pos} selected"

    while self.display.selected
      self.display.move_cursor
      system("clear")
      self.display.render_board
    end

    end_pos = self.display.cursor
    self.board.move(start_pos, end_pos)
  end

end
