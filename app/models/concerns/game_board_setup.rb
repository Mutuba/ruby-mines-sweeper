# app/models/concerns/game_board_setup.rb

module GameBoardSetup
  extend ActiveSupport::Concern

  included do
    after_create :setup_board
  end

  def setup_board
    create_cells
    place_mines
    calculate_adjacent_mines
  end

  private

  def create_cells
    rows.times do |row|
      cols.times do |col|
        cells.create(row: row, col: col, mine: false, revealed: false, flag: false, adjacent_mines: 0)
      end
    end
  end

  def place_mines
    mine_count.times do
      loop do
        cell = cells.sample
        unless cell.mine?
          cell.update(mine: true)
          break
        end
      end
    end
  end

  def calculate_adjacent_mines
    cells.each do |cell|
      adjacent_mines = neighboring_cells(cell).count(&:mine?)
      cell.update(adjacent_mines: adjacent_mines)
    end
  end
end