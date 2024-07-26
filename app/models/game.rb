# == Schema Information
#
# Table name: games
#
#  id         :bigint           not null, primary key
#  rows       :integer
#  cols       :integer
#  mine_count :integer
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  level      :integer          default("beginner")
#

# --> BEGINNER = 9 * 9 Cells and 10 Mines
# --> INTERMEDIATE = 16 * 16 Cells and 40 Mines
# --> ADVANCED = 24 * 24 Cells and 99 Mines

class Game < ApplicationRecord
  BEGINNER_ROWS = 9
  BEGINNER_COLS = 9
  BEGINNER_MINES = 10

  INTERMEDIATE_ROWS = 16
  INTERMEDIATE_COLS = 16
  INTERMEDIATE_MINES = 40

  ADVANCED_ROWS = 24
  ADVANCED_COLS = 24
  ADVANCED_MINES = 99

  enum level: {
    beginner: 0,
    intermediate: 1,
    advanced: 2
  }
  
  enum state: {
    pending: 0,
    ongoing: 1,
    won: 2,
    lost: 3
  }

  belongs_to :user
  has_many :cells, dependent: :destroy

  before_validation :set_dimensions_and_mine_count, on: :create
  after_create :setup_board

  private

  def set_dimensions_and_mine_count
    case level
    when 'beginner'
      self.rows ||= BEGINNER_ROWS
      self.cols ||= BEGINNER_COLS
      self.mine_count ||= BEGINNER_MINES
    when 'intermediate'
      self.rows ||= INTERMEDIATE_ROWS
      self.cols ||= INTERMEDIATE_COLS
      self.mine_count ||= INTERMEDIATE_MINES
    when 'advanced'
      self.rows ||= ADVANCED_ROWS
      self.cols ||= ADVANCED_COLS
      self.mine_count ||= ADVANCED_MINES
    end
  end

  def setup_board
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

  # for a cell at 2,2
  # 1,1  1,2  1,3
  # 2,1       2,3
  # 3,1  3,2  3,3
  def neighboring_cells(cell)
    cells.where(row: (cell.row - 1)..(cell.row + 1), col: (cell.col - 1)..(cell.col + 1)).where.not(id: cell.id)
  end
end