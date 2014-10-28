# Ellery Temple Jr.
# 10/27/14
# Tic-Tac-Toe Object Oriented

require 'set'
require 'pry'

class GameBoard
  attr_accessor :tile

  def initialize
    @tile = {}
    (1..9).each {|value| @tile[value] = ' '}
  end

  def draw
    system 'clear'
    puts 
    puts "     |     |"
    puts "  #{tile[1]}  |  #{tile[2]}  |  #{tile[3]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{tile[4]}  |  #{tile[5]}  |  #{tile[6]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{tile[7]}  |  #{tile[8]}  |  #{tile[9]}  "
    puts "     |     |"
    puts 
  end

  def clear
    system 'clear'
    (1..@tile.length).each {|value| @tile[value] = ' '}
  end

  def marked?(value)
    tile[value] != ' '
  end

  def empty_tiles
    tile.select {|k, value| value != 'X' && value != 'O'}
  end
end

class Player
  attr_reader :name

  def initialize(n)
    @name = n
  end
end

class Game
  attr_accessor :gameboard
  attr_reader :player, :computer

  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @player = Player.new('Player')
    @computer = Player.new('Jarvis')
    @gameboard = GameBoard.new
  end

  def play
    loop do
      gameboard.draw
      begin
        player_marks_board
        break if we_have_a_winner
        computer_marks_board
        break if we_have_a_winner
      end until we_have_a_winner || no_more_moves?

      puts we_have_a_winner

      replay == 'n' ? break : clear_game
    end
    puts "Thanks for playing #{player.name}!"
  end

  # =========================================================================
  private

  def replay
    puts "Would you like to play again? (Y/N)"
    loop do
      answer = gets.chomp.downcase
      if !['y', 'n'].include?(answer)
        puts "Invalid selection, please try again."
      else
        return answer
      end
    end
  end

   def player_marks_board
    print "Choose a position (from 1 to 9) to place a piece: "

    loop do
      request = gets.chomp.to_i

      if !valid_request?(request)
        puts "Invalid selection, please try again."
      elsif gameboard.marked?(request) 
        puts "Tile already marked, please choose another tile."
      else
        gameboard.tile[request] = 'X'
        break
      end
    end
    gameboard.draw
  end

  def computer_marks_board
    request = gameboard.empty_tiles.keys.sample
    gameboard.tile[request] = 'O'
    gameboard.draw
  end

  def valid_request?(request)
    (1..9).include?(request)
  end

  def no_more_moves?
    gameboard.tile.values.all? {|value| value != ' '} 
  end

  def clear_game
    gameboard.clear
  end

  def we_have_a_winner
    
    player_moves   = gameboard.tile.select {|k, played_positions| played_positions == 'X'}.keys.to_set
    computer_moves = gameboard.tile.select {|k, played_positions| played_positions == 'O'}.keys.to_set

    WINNING_LINES.each do |line|
      return "#{player.name} won!" if line.to_set.subset?(player_moves)
      return "#{computer.name} won!" if line.to_set.subset?(computer_moves)
    end
    nil
  end
end

Game.new.play