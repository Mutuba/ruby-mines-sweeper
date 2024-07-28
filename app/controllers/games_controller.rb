# app/controllers/games_controller.rb
class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def new
    @game = current_user.games.new
  end

  def create
    @game = current_user.games.new(game_params)
    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = current_user.games.find(params[:id])
    if @game.state == "not_started"
      @game.update_attribute(:state, :in_progress)
    end
  end

  private

  def game_params
    params.require(:game).permit(:level, :rows, :cols, :mine_count)
  end
end
