# == Schema Information
#
# Table name: cells
#
#  id             :bigint           not null, primary key
#  game_id        :bigint           not null
#  row            :integer
#  col            :integer
#  mine           :boolean
#  revealed       :boolean
#  flag           :boolean
#  adjacent_mines :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Cell < ApplicationRecord
  belongs_to :game

  def reveal
    return if revealed?

    update(revealed: true)
    game.update(state: :lost) if mine?

    if adjacent_mines.zero?
      game.neighboring_cells(self).each(&:reveal)
    end

    check_win_condition
  end

  def flag!
    update(flag: !flag)
  end

  private

  def check_win_condition
    if game.cells.where(mine: false, revealed: false).empty?
      game.update(state: :won)
    end
  end
end
