# frozen_string_literal: true

# Class Board for display board, update
class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, '-') } # immutable, Create 3x3 grid
    @entered_grid = Array
    # immutable[0][0] = 1000
  end

  def display
    @grid.each { |row| puts row.join(' ') } # Joins the " " in each row
  end

  def update(position, symbol)
    row, col = position
    if @grid[row][col] == '-'
      @grid[row][col] = symbol
      true
    else
      false
    end
  end

  def full?
    @grid.all? { |row| row.none? { |cell| cell == '-' } } # Check if grid is full
  end
end
