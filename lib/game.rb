# frozen_string_literal: true

require_relative 'board'

# Class Game check winner, play, switchplayer
class Game
  def initialize
    @board = Board.new # Initialize new object "@board" from Board class
    @current_player = 'X'
    @entered_position = []
  end

  def play
    loop do
      @board.display
      position = valid_position

      next if handle_move(position)
      break if check_game_over
    end
  end

  private

  def handle_move(position)
    if @board.update(position, @current_player)
      false
    else
      puts 'Invalid move! Spot already taken. Try again.'
      true
    end
  end

  def check_game_over
    return true if game_won?
    return true if game_draw?

    switch_player
    false
  end

  private
  
  def game_won?
    if winner?
      @board.display
      puts "Player #{@current_player} wins!"
      true
    else
      false
    end
  end

  def game_draw?
    if @board.full?
      @board.display
      puts "It's a draw"
      true
    else
      false
    end
  end

  def entered_position?(position)
    p @entered_position.include?(position)
  end

  def valid_position
    loop do
      puts "Player #{@current_player}, choose a position (row, col):"
      input = gets.chomp.split.map(&:to_i)

      # Validate sanitize input
      return input if input.size == 2 && input.all? { |n| n.between?(0, 2) }

      puts "Invalid input. Please enter two numbers between 0 and 2. #{input}"
    end
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X' # Change current player value
  end

  def winner?
    winning_combinations = [
      [[0, 0], [0, 1], [0, 2]], # Top row
      [[1, 0], [1, 1], [1, 2]], # Middle row
      [[2, 0], [2, 1], [2, 2]], # Bottem row
      [[0, 0], [1, 0], [2, 0]], # Left column
      [[0, 1], [1, 1], [2, 1]], # Middle column
      [[0, 2], [1, 2], [2, 2]], # Right column
      [[0, 0], [1, 1], [2, 2]], # Diagonal \
      [[0, 2], [1, 1], [2, 0]]  # Diagonal /
    ]

    winning_combinations.any? do |combination|
      p(combination.all? { |row, col| @board.instance_variable_get(:@grid)[row][col] == @current_player })
    end
  end
end

# Game.new.play
