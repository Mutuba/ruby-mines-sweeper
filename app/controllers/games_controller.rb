# app/controllers/games_controller.rb
class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, except: %i[index new create] 

  def index
    @games = current_user.games
  end

  def new
    @game = current_user.games.new
  end

  def show
    if @game.state == "not_started"
      @game.update_attribute(:state, :in_progress)
    end
  end

  def create
    @game = current_user.games.new(game_params)
    if @game.save
      redirect_to games_path, notice: 'Game was successfully created.'
    else      
      render :new
    end
  end

  def update
    if @game.update(game_params)      
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_game
    @game = current_user.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:level, :rows, :cols, :mine_count)
  end
end
