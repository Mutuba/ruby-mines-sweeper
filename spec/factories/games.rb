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
    rows {Faker::Number.within(range: 1..10)}
    cols {Faker::Number.within(range: 1..10)}
    mine_count {Faker::Number.within(range: 1..10)}
    association :user, factory: :user
  end
end
