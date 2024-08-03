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
require 'rails_helper'

RSpec.describe Cell, type: :model do
  # Associations
  it { should belong_to :game }
  # Validate Column
  it { should have_db_column(:game_id).of_type(:integer) }
  it { should have_db_column(:row).of_type(:integer) }
  it { should have_db_column(:col).of_type(:integer) }
  it { should have_db_column(:adjacent_mines).of_type(:integer) }
  it { should have_db_column(:mine).of_type(:boolean) }
  it { should have_db_column(:revealed).of_type(:boolean) }
  it { should have_db_column(:flag).of_type(:boolean) }

  # callbacks validation
  context "callbacks" do
      let(:game) { create(:game) }
      let!(:cell) { create(:cell, game: game, revealed: true)}
      before { game.update(state: :lost) }

    it 'raises an error when trying to update a cell if the game is lost' do
      expect { cell.update!(revealed: false) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Cannot update a cell because the game is lost.")
      cell.reload
      expect(cell.revealed).to eq true
    end
  end
end
