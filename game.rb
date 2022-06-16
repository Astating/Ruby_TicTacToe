class Game
  attr_reader :board, :player_one, :player_two, :current_player

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @current_player = nil
  end

  def create_players
    name = nil
    while name.to_s.strip.empty? do
      puts "What's Player 1's name ?"
      name = gets.chomp
    end

    symbol = nil
    until %w[X O].include?(symbol)
      puts "what's #{name}'s symbol ? (X/O)"
      symbol = gets.chomp.upcase
    end

    @player_one = Player.new(name, symbol)

    name2 = nil
    while name2.to_s.strip.empty? || name2 == name
      puts "What's Player 2's name ?"
      name2 = gets.chomp
    end

    symbol2 = player_one.symbol == 'X' ? 'O' : 'X'
    @player_two = Player.new(name2, symbol2)
  end

  def start
    create_players
    puts "#{player_one.name} plays #{player_one.symbol}, #{player_two.name} plays #{player_two.symbol}!"
    @current_player = player_one
    play
  end

  def play
    until board.game_won? || board.full?
      board.display
      puts "Please play, #{current_player.name} (#{current_player.symbol})."
      make_a_move
    end

    board.display
    if board.game_won?
      change_turn
      puts "Congratulations, #{current_player.name}, you've WON!"
    else
      puts "\n Aah... A tie? Disappointing..."
    end
    
    the_end
  end

  def make_a_move
    loop do
      move = gets.chomp.to_i
      if board.valid_move?(move)
        board.update(move, current_player.symbol)
        change_turn
        break
      end
    end
  end

  def change_turn
    @current_player = current_player == player_one ? player_two : player_one
  end

  def reset_board
    @board = Board.new
    change_turn
    play
  end

  def reset_game
    @board = Board.new
    start
  end

  def the_end
    choice = nil
    until %w(1 2 3).include?(choice)
      puts <<-HEREDOC

What would you like to do ?
  -Reset the board: 1
  -Reset the game: 2
  -Quit : 3
      HEREDOC

      choice = gets.chomp.strip
    end

    case choice.to_i
    when 1
      reset_board
    when 2
      reset_game
    when 3
      puts "\n Thanks for playing! \n"
    end
  end
end
