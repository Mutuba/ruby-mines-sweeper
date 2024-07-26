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
require 'rails_helper'

RSpec.describe Game, type: :model do
  # Association tests
  it { should belong_to(:user) }
  it { should have_many(:cells).dependent(:destroy) }
  it { should validate_presence_of(:rows) }
  it { should validate_presence_of(:cols) }
  it { should validate_inclusion_of(:state).in_array(%w[pending ongoing won lost]) }

  it "initializes the board correctly" do
    user = create(:user)
    game = Game.create(rows: 5, cols: 5, mine_count: 5, state: 'pending', user: user)
        
        binding.pry
        
    expect(game.cells.count).to eq(25)
    expect(game.cells.where(mine: true).count).to eq(5)
  end 
end
