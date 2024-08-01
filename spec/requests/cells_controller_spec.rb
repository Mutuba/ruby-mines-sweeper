require 'rails_helper'

RSpec.describe CellsController, type: :request do

 let(:user) { create(:user) }
 let!(:game) { create(:game, user: user, rows: 2, cols: 2, mine_count: 0) }
 let(:cell) { game.cells.first }
 before { sign_in user }

  describe "UPDATE #update" do
    before do
      patch game_cell_path(game, cell)
    end

    it "should update cells" do
      expect(response).to have_http_status 302
      expect(response).to redirect_to(game)   
    end
  end

  describe "FLAG #flag" do

    before do
      patch flag_game_cell_path(game, cell)
    end

    it "should flag cells" do
      expect(response).to have_http_status 302
      expect(response).to redirect_to(game)  
    end
  end
end