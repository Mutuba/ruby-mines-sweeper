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
FactoryBot.define do
  factory :cell do
    association :game, factory: :game
    row { 1 }
    col { 1 }
    mine { false }
    revealed { false }
    flag { false }
    adjacent_mines { 1 }
  end
end
