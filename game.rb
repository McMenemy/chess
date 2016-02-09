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
    self.display.render_board
    
    until game_over?
      take_turn(self.current_player)
      p "in check? white: #{self.board.in_check?(:white)}"
      p "check_mate? white: #{self.board.check_mate?(:white)}"
      p "in check? black: #{self.board.in_check?(:black)}"
      p "check_mate? black: #{self.board.check_mate?(:black)}"
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
      input = get_input
      self.display.move_cursor(input) if move_input?(input)
      system("clear")
      self.display.render_board
    end

    
    start_pos = self.display.cursor
    
    if valid_selection?(start_pos)
      system("clear")
      self.display.redner_board_with_path(self.board[*start_pos].possible_moves)
      input = self.display.cursor
      
      while move_input?(input)
        input = get_input
        self.display.move_cursor(input) if move_input?(input)
        system("clear")
        self.display.redner_board_with_path(self.board[*start_pos].possible_moves)
      end
        
      end_pos = self.display.cursor
      
      if self.board.move(start_pos, end_pos) == 'invalid move'
        puts 'Invalid move.'
        puts 'Reselect a piece and try a different move'
      else
        system("clear")
        self.display.render_board
        switch_player
      end
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
      puts '  * Use wsad to move cursors'
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

end
