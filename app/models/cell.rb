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

  validate :prevent_state_change_if_game_is_lost, on: :update

  def flag!
    !update(flag: !flag)
  end

  private

  def prevent_state_change_if_game_is_lost    
    if game.state.to_sym == :lost
      errors.add(:base, "Cannot update a cell because the game is lost.")
    end
  end
end
