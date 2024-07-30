require 'rails_helper'

RSpec.describe CellRevealService do

  describe "# call" do
    let(:cell) { create(:cell) }

    it "should update the cell" do
      CellRevealService.call(cell: cell)
      expect(cell.revealed).to eq(true)      
    end

    context 'when cell is already revealed' do
      before { cell.update(revealed: true) }

      it 'does nothing' do
        expect { CellRevealService.call(cell: cell) }.not_to change { cell.revealed }
      end
    end

    context 'when cell is a mine' do
      before { cell.update(mine: true) }

      it 'sets the game state to lost' do
        expect { CellRevealService.call(cell: cell) }.to change { cell.game.state }
      end
    end
  end
end