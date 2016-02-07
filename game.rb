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

    # play
  end

  def play
    self.display.render_board
    
    until game_over?
      take_turn(self.current_player)
      # p "in check?: #{self.board.in_check?(:white)}"
      # p "check_mate?: #{self.board.check_mate?(:white)}"
      self.turn_count += 1
    end
    p 'game over'
  end
  
  def game_over?
    self.quit
  end
  
  def switch_player
    if self.current_player == self.player1 
      self.current_player = self.player2
    else
      self.current_player = self.player1
    end
  end

  def take_turn(player)
    input = self.display.cursor
      
    while move_input?(input)
      input = self.display.get_input
      self.display.move_cursor(input) if move_input?(input)
      system("clear")
      self.display.render_board
    end

    start_pos = self.display.cursor
    
    if valid_selection?(start_pos)
      input = self.display.cursor
      
      while move_input?(input)
        input = self.display.get_input
        self.display.move_cursor(input) if move_input?(input)
        system("clear")
        self.display.render_board
      end
        
      end_pos = self.display.cursor
      self.board.move(start_pos, end_pos)
      system("clear")
      self.display.render_board
      switch_player
    end
  end
  
  def valid_selection?(pos)
    if self.board[*pos].color != self.current_player.color
      puts "Invalid Selection: choose a #{self.current_player.color} piece."
      return false
    else
      return true
    end
  end
  
  def move_input?(input)  # works in pry
    if input == 'exit program'
      puts 'You quit the game.'
      self.quit = true
      return false
    elsif input == 'try again'
      puts 'Invalid selection: '
      puts '  * Use wsad to move curse'
      puts '  * Press q to select a piece'
      puts '  * Press e to exit program'
      return false
    elsif input == 'selected'
      puts "Position #{self.display.cursor} selected."
      return false
    else
      return true
    end
  end

end
