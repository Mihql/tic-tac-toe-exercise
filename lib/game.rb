require_relative "board.rb"

class Game
  def initialize
    @board = Board.new # Initialize new object "@board" from Board class 
    @current_player = "X"
    @entered_position = []
  end

  def play
    loop do
      @board.display # Call display from Board class
      position = get_valid_position

      if is_entered_position?(position)
        puts "Position already taken, Choose another one"
        next # Skip the rest of the loop and ask for input again
      end

      if @board.update(position, @current_player) # Call update Board class pass position and @current_player argument
        @entered_position << position
        # Check for a win or a full borad (draw)
        if winner?
          @board.display
          puts "Player #{@current_player} wins!"
          break
        elsif @board.full?
          @board.display
          puts "It's a draw"
          break
        else
          switch_player
        end
      else
        puts "Invalid move spot already taken. Try again"
      end
    end
  end

  def is_entered_position?(position)
    @entered_position.include?(position)
  end

  def get_valid_position
    loop do
      puts "Player #{@current_player}, choose a position (row, col):"
      input = gets.chomp.split.map(&:to_i)

      # Validate sanitize input
      if input.size == 2 && input.all? { |n| n.between?(0, 2) }
        return input
      else
        puts "Invalid input. Please enter two numbers between 0 and 2. #{input}"
      end
    end
  end


  def switch_player 
    @current_player = @current_player == "X" ? "O" : "X" # Change current player value 
  end

  def winner?
    winning_combinations = [
      [[0,0], [0,1], [0,2]], # Top row
      [[1,0], [1,1], [1,2]], # Middle row
      [[2,0], [2,1], [2,2]], # Bottem row
      [[0,0], [1,0], [2,0]], # Left column
      [[0,1], [1,1], [2,1]], # Middle column
      [[0,2], [1,2], [2,2]], # Right column
      [[0,0], [1,1], [2,2]], # Diagonal \
      [[0,2], [1,1], [2,0]]  # Diagonal /
    ]
    
    winning_combinations.any? do |combination|
      combination.all? { |row, col| @board.instance_variable_get(:@grid)[row][col] == @current_player }
    end
  end
end

# Game.new.play