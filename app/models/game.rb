class Game < ApplicationRecord
  belongs_to :user
  has_many :cells, dependent: :destroy

  validates :rows, :cols, :mine_count, presence: true
  validates :state, inclusion: { in: %w[pending ongoing won lost] }

  after_create :setup_board

  def setup_board
    # Initialize the board with cells
    rows.times do |row|
      cols.times do |col|
        cells.create(row: row, col: col, mine: false, revealed: false, flag: false, adjacent_mines: 0)
      end
    end
    place_mines
    calculate_adjacent_mines
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

  def neighboring_cells(cell)
    cells.where(row: (cell.row - 1)..(cell.row + 1), col: (cell.col - 1)..(cell.col + 1)).where.not(id: cell.id)
  end
end
