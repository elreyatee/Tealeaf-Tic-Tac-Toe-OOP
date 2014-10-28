# Ellery Temple Jr.
# 10/27/14
# Tic-Tac-Toe Object Oriented

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

  def initialize
    puts "Hello, let's play Tic-Tac-Toe!"
    puts "My name is Jarvis, what's your name?"

    @player = Player.new(gets.chomp)
    @computer = Player.new('Jarvis')
    @gameboard = GameBoard.new
    puts "Nice to meet you #{@player.name}. Let's play!"
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

  private

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
    case
    when ((gameboard.tile[1] == 'X' && gameboard.tile[2] == 'X' && gameboard.tile[3] == 'X') || (gameboard.tile[4] == 'X' && gameboard.tile[5] == 'X' && gameboard.tile[6] == 'X') || 
          (gameboard.tile[7] == 'X' && gameboard.tile[8] == 'X' && gameboard.tile[9] == 'X') || (gameboard.tile[7] == 'X' && gameboard.tile[8] == 'X' && gameboard.tile[9] == 'X') ||
          (gameboard.tile[1] == 'X' && gameboard.tile[4] == 'X' && gameboard.tile[7] == 'X') || (gameboard.tile[2] == 'X' && gameboard.tile[5] == 'X' && gameboard.tile[9] == 'X') ||
          (gameboard.tile[3] == 'X' && gameboard.tile[6] == 'X' && gameboard.tile[9] == 'X') || (gameboard.tile[1] == 'X' && gameboard.tile[5] == 'X' && gameboard.tile[9] == 'X') ||
          (gameboard.tile[3] == 'X' && gameboard.tile[5] == 'X' && gameboard.tile[7] == 'X'))
          return "#{player.name} won!"
    when ((gameboard.tile[1] == 'O' && gameboard.tile[2] == 'O' && gameboard.tile[3] == 'O') || (gameboard.tile[4] == 'O' && gameboard.tile[5] == 'O' && gameboard.tile[6] == 'O') || 
          (gameboard.tile[7] == 'O' && gameboard.tile[8] == 'O' && gameboard.tile[9] == 'O') || (gameboard.tile[7] == 'O' && gameboard.tile[8] == 'O' && gameboard.tile[9] == 'O') ||
          (gameboard.tile[1] == 'O' && gameboard.tile[4] == 'O' && gameboard.tile[7] == 'O') || (gameboard.tile[2] == 'O' && gameboard.tile[5] == 'O' && gameboard.tile[9] == 'O') ||
          (gameboard.tile[3] == 'O' && gameboard.tile[6] == 'O' && gameboard.tile[9] == 'O') || (gameboard.tile[1] == 'O' && gameboard.tile[5] == 'O' && gameboard.tile[9] == 'O') ||
          (gameboard.tile[3] == 'O' && gameboard.tile[5] == 'O' && gameboard.tile[7] == 'O'))
          return "#{computer.name} won!"
    end
    nil
  end
end

Game.new.play