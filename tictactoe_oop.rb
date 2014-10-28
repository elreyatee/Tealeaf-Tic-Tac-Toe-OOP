# Ellery Temple Jr.
# 10/26/14
# Tic-Tac-Toe Object Oriented

class GameBoard
  attr_accessor :board

  def initialize
    @board = {}
    (1..9).each {|tile| @board[tile] = ' '}
  end

  def draw
    system 'clear'
    puts "     |     |     "
    puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
    puts "     |     |     "
  end

  def clear
    system 'clear'
    (1..board.length).each {|tiles| board[tiles] = ' '}
  end
end

class Player
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def move(game)
    loop do
      tile_request = gets.chomp.to_i

      if !(1..9).include?(tile_request)
        puts "Invalid selection, please try again."
      elsif game.board[tile_request] != ' ' #already marked
        puts "Tile already marked, please choose another tile."
      else
        game.board[tile_request] = 'X'
        break
      end
    end
    game.draw
  end
end

class Computer < Player
  def move(game)
    tile_request = game.board.select {|k, v| v != 'X' && v != 'O'}.keys.sample
    game.board[tile_request] = 'O'
    game.draw
  end
end

class TicTacToe
  attr_accessor :game
  attr_reader :player, :computer

  def initialize
    puts "Hello, let's play Tic-Tac-Toe!"
    puts "My name is Jarvis, what's your name?"

    @player = Player.new(gets.chomp)
    @computer = Computer.new('Jarvis')
    @game = GameBoard.new

    puts "Nice to meet you #{@player.name}. Let's play!"
  end

  def check_winner
    case
    when ((game.board[1] == 'X' && game.board[2] == 'X' && game.board[3] == 'X') || (game.board[4] == 'X' && game.board[5] == 'X' && game.board[6] == 'X') || 
          (game.board[7] == 'X' && game.board[8] == 'X' && game.board[9] == 'X') || (game.board[7] == 'X' && game.board[8] == 'X' && game.board[9] == 'X') ||
          (game.board[1] == 'X' && game.board[4] == 'X' && game.board[7] == 'X') || (game.board[2] == 'X' && game.board[5] == 'X' && game.board[9] == 'X') ||
          (game.board[3] == 'X' && game.board[6] == 'X' && game.board[9] == 'X') || (game.board[1] == 'X' && game.board[5] == 'X' && game.board[9] == 'X') ||
          (game.board[3] == 'X' && game.board[5] == 'X' && game.board[7] == 'X'))
          return "#{player.name} won!"
    when ((game.board[1] == 'O' && game.board[2] == 'O' && game.board[3] == 'O') || (game.board[4] == 'O' && game.board[5] == 'O' && game.board[6] == 'O') || 
          (game.board[7] == 'O' && game.board[8] == 'O' && game.board[9] == 'O') || (game.board[7] == 'O' && game.board[8] == 'O' && game.board[9] == 'O') ||
          (game.board[1] == 'O' && game.board[4] == 'O' && game.board[7] == 'O') || (game.board[2] == 'O' && game.board[5] == 'O' && game.board[9] == 'O') ||
          (game.board[3] == 'O' && game.board[6] == 'O' && game.board[9] == 'O') || (game.board[1] == 'O' && game.board[5] == 'O' && game.board[9] == 'O') ||
          (game.board[3] == 'O' && game.board[5] == 'O' && game.board[7] == 'O'))
          return "#{computer.name} won!"
    end
    nil
  end

  def no_more_moves?
    game.board.values.all? {|tiles| tiles != ' '} 
  end

  def clear_game
    game.clear
  end

  def play
    loop do
      game.draw
      begin
        print "Choose a position (from 1 to 9) to place a piece: "
        player.move(game)
        computer.move(game)
        winner = check_winner
      end until winner || no_more_moves?

      puts winner

      puts "Would you like to play again? (Y/N)"
      answer = gets.chomp.downcase
      answer == 'n' ? break : clear_game
    end
    puts "Thanks for playing #{player.name}!"
  end
end

TicTacToe.new.play