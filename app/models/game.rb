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
  include GameConstants
  include GameBoardSetup

  enum level: {
    beginner: 0,
    intermediate: 1,
    advanced: 2
  }
  
  enum state: {
    not_started: 0,
    in_progress: 1,
    won: 2,
    lost: 3
  }

  belongs_to :user
  has_many :cells, dependent: :destroy

  before_validation :set_dimensions_and_mine_count, on: :create

  def progress_percentage
    ((cells.where(revealed: true).size.to_f / cells.size) * 100).round
  end

  def check_win_condition    
    if cells.where(mine: false, revealed: false).empty?
      update(state: :won)
    end
  end

  # for a cell at 2,2
  # 1,1  1,2  1,3
  # 2,1       2,3
  # 3,1  3,2  3,3
  def neighboring_cells(cell)
    cells.where(row: (cell.row - 1)..(cell.row + 1), col: (cell.col - 1)..(cell.col + 1)).where.not(id: cell.id)
  end

  private

  def set_dimensions_and_mine_count
    case level
    when 'beginner'
      self.rows ||= BEGINNER_ROWS
      self.cols ||= BEGINNER_COLS
      self.mine_count ||= 10
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
end

# class Order < ActiveRecord::Base
#   has_many :line_items

#   validates :total_price, numericality: true

#   before_create :apply_returning_customer_discount, if: lambda { |order| order.returning_customer? }

#   def apply_returning_customer_discount
#     self.total_price = self.total_price * 0.9
#   end
# end