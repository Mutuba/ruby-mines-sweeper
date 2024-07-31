require 'rails_helper'

RSpec.describe CellRevealService do

  describe "# call" do
    let(:game) { create(:game)}
    let(:cell) { create(:cell, game: game, adjacent_mines: 0) }

    context 'when cell is not revealed' do
      it "should update the cell to revealed" do
        CellRevealService.call(cell: cell)
        expect(cell.revealed).to eq(true)      
      end
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
        CellRevealService.call(cell: cell)
        expect(game.state).to eq 'lost'      
      end
    end

    context 'checking win condition' do
      before { allow(game).to receive(:check_win_condition).and_call_original }
      it 'calls the check_win_condition method on the game' do
        CellRevealService.call(cell: cell)
        expect(game).to have_received(:check_win_condition)
      end
    end

    context 'when cell has no adjacent mines' do
      let!(:neighboring_cells) { create_list(:cell, 3, game: game, revealed: false, mine: false, adjacent_mines: 0) }

      before do
        allow(game).to receive(:neighboring_cells).with(cell).and_return(neighboring_cells)
      end

      it 'reveals all neighboring cells' do
        CellRevealService.call(cell: cell)

        neighboring_cells.each do |neighbor|          
          expect(neighbor.revealed).to eq true
        end
      end
    end

    context 'when cell has adjacent mines' do
      before { cell.update(adjacent_mines: 1) }

      it 'does not reveal neighboring cells' do
        neighboring_cells = create_list(:cell, 3, game: game, revealed: false, mine: false)
        allow(game).to receive(:neighboring_cells).with(cell).and_return(neighboring_cells)
        CellRevealService.call(cell: cell)
        neighboring_cells.each do |neighbor|
          expect(neighbor.revealed).to eq false
        end
      end
    end
  end
end