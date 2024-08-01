require 'rails_helper'

RSpec.describe CellRevealService do
  describe "# call" do
    let(:game) { create(:game, rows: 2, cols: 2, mine_count: 0)}
    let(:cell) { create(:cell, game: game, col: 2, row: 2) }
    let(:neighboring_cells) { create_list(:cell, 3, game: game) }
    let(:game_cells) { game.cells }

    context 'when cell is not revealed' do
      before { cell.update!(mine: false) }
      
      it "should update the cell to revealed" do
        result = CellRevealService.call(cell: cell)
        expect(cell.revealed).to eq(true)
      end
    end

    context 'when an error occurs in the transaction' do
      before do
        cell.update!(mine: true)
        # raising an exception, causes the transaction to be rolled back, but the exception is ignored
        # it will not be passed on to be handled in the rescue block
        # Notes here: https://api.rubyonrails.org/classes/ActiveRecord/Rollback.html
        allow(game).to receive(:update!).with(state: :lost).and_raise(ActiveRecord::Rollback)
      end
      it 'does not commit any changes and rolls back the transaction' do
        CellRevealService.call(cell: cell)
        expect(cell.reload.revealed).to be false
        expect(game.reload.state).not_to eq 'lost'  
      end
    end

    context 'when cell is already revealed' do
      before { cell.update(revealed: true) }

      it 'does nothing' do
        expect { CellRevealService.call(cell: cell) }.not_to change { cell.revealed }
        expect(game).not_to receive(:update!).with(any_args)
      end
    end

    context 'when cell is a mine' do
      before { cell.update(mine: true) }

      it 'sets the game state to lost' do
        CellRevealService.call(cell: cell)
        expect(game.state).to eq 'lost'      
      end
    end

    context 'when cell has no adjacent mines' do
      before do
        allow(game).to receive(:neighboring_cells).with(cell).and_return(neighboring_cells)
        allow(game_cells).to receive(:where).with(mine: false, revealed: false).and_return([])
      end

      it 'reveals all neighboring cells' do
        CellRevealService.call(cell: cell)
        neighboring_cells.each do |neighbor|          
          expect(neighbor.revealed).to eq true
        end
        expect(game_cells).to have_received(:where).with(mine: false, revealed: false)
      end
    end

    context 'when cell has adjacent mines' do
      before do
        cell.update(adjacent_mines: 1)
        allow(game).to receive(:neighboring_cells).with(cell).and_return(neighboring_cells)
      end

      it 'does not reveal neighboring cells' do
        CellRevealService.call(cell: cell)
        neighboring_cells.each do |neighbor|
          expect(neighbor.revealed).to eq false
        end
      end
    end
  end
end