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
FactoryBot.define do
  factory :game do
    
  end
end
