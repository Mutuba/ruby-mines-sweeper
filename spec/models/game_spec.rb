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

  # Validations
  it { should define_enum_for(:level).with_values(beginner: 0, intermediate: 1, advanced: 2, custom: 3) }
  it { should define_enum_for(:state).with_values(not_started: 0, in_progress: 1, won: 2, lost: 3) }

  it "initializes the board correctly" do
    user = create(:user)
    game = Game.create(level: :beginner, user: user)    
    expect(game.cells.count).to eq(81)
    expect(game.cells.where(mine: true).count).to eq(10)
  end 

  context "callback" do
    let!(:game) { create(:game, state: :in_progress)}
    before { game.update(state: :lost)}

    it "does not allow updating if game is in lost state" do
      expect { game.update!(state: :in_progress) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: State cannot be changed once the game is lost.")
    end
  end
end
