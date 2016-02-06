require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  attr_reader :player1, :player2, :board, :display
  attr_accessor :current_player, :turn_count, :quit

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @current_player = @player1
    @turn_count = 0 # temp variable for testing
    @quit = false
    
    play
  end

  def play
    until game_over?
      take_turn(self.current_player)
      switch_player
      p "in check?: #{self.board.in_check?(:white)}"
      p "check_mate?: #{self.board.check_mate?(:white)}"
      self.turn_count += 1
    end
    p 'game over'
  end
  
  def game_over?
    self.quit || self.turn_count > 50 ? true : false
  end
  
  def switch_player
    if self.current_player == self.player1 
      self.current_player = self.player2
    else
      self.current_player = self.player1
    end
  end

  def take_turn(player1)
    if self.display.quit
      p 'quit at game level'
      raise error
      self.quit = true
      return
    end
      
    until self.display.selected || self.display.quit
      self.display.move_cursor
      system("clear")
      self.display.render_board
    end

    start_pos = self.display.cursor
    puts "piece at #{start_pos} selected"

    while self.display.selected && !self.display.quit
      self.display.move_cursor
      system("clear")
      self.display.render_board
    end

    end_pos = self.display.cursor
    self.board.move(start_pos, end_pos)
  end
    
end
