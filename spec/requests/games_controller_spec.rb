require 'rails_helper'

RSpec.describe GamesController, type: :request do
  describe "GET #index" do
    let(:user) { create(:user) }
    let!(:games) { create_list(:game, 5, rows: 1, cols: 1, mine_count: 1, user: user) }

    before do
      sign_in user
      get games_path
    end
    it "returns a list of games" do
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    let(:user) { create(:user) }
    let!(:game) { create(:game, rows: 1, cols: 1, mine_count: 1, user: user) }

    before do
      sign_in user
      get game_path(game.id)
    end

    it "returns game" do
      expect(response).to be_successful
    end
  end

  describe "POST #create with valid params" do
    let(:user) { create(:user) }
    let(:game_params) { attributes_for(:game)}
    before do
      sign_in user
    end

    it "creates a new game" do
      expect {
        post games_path, params: { game: game_params }
      }.to change(Game, :count).by(1)
      expect(response.status).to eq 302  
      expect(response).to redirect_to games_path
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user) }
    let!(:game) { create(:game, rows: 1, cols: 1, mine_count: 1, user: user) }
    let(:new_attributes) { { rows: 2, cols: 2, mine_count: 2 } }
  
    before do
      sign_in user
    end
  
    context "with valid parameters" do
      it "updates the game" do
        patch game_path(game), params: { game: new_attributes }
        game.reload
        expect(game.rows).to eq(new_attributes[:rows])
        expect(game.cols).to eq(new_attributes[:cols])
        expect(game.mine_count).to eq(new_attributes[:mine_count])
        expect(response).to redirect_to(game)
      end
    end
  end

  # describe "DELETE #destroy" do
  #   let(:user) { create(:user) }
  #   let!(:game) { create(:game, rows: 1, cols: 1, mine_count: 1, user: user) }
  
  #   before do
  #     sign_in user
  #   end
  
  #   it "deletes the game" do
  #     expect {
  #       delete game_path(game)
  #     }.to change(Game, :count).by(-1)
  #   end
  # end
end