class Board
  attr_reader :cells

  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display
    puts <<-HEREDOC

               #{cells[0]} | #{cells[1]} | #{cells[2]}
              ---+---+---
               #{cells[3]} | #{cells[4]} | #{cells[5]}
              ---+---+---
               #{cells[6]} | #{cells[7]} | #{cells[8]}

    HEREDOC
  end

  def update(cell, symbol)
    # valid_move
    cells[cell - 1] = symbol
  end

  def valid_move?(cell)
    cells[cell - 1] == cell
  end

  def full?
    cells.all? { |cell| cell =~ /\D/ } # /\D/ = /[^0-9]/ = non-digits
  end

  def game_won?
    WINNING_COMBINATIONS.any? do |combo|
      [cells[combo[0]], cells[combo[1]], cells[combo[2]]].uniq.length == 1
    end
  end
end
