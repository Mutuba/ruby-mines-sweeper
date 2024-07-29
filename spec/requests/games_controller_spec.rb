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
end