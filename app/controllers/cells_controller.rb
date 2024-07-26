# app/controllers/cells_controller.rb
class CellsController < ApplicationController
  before_action :authenticate_user!

  def update
    @cell = current_user.games.find(params[:game_id]).cells.find(params[:id])
    @cell.reveal
    redirect_to @cell.game
  end

  def flag
    @cell = current_user.games.find(params[:game_id]).cells.find(params[:id])
    @cell.flag!
    redirect_to @cell.game
  end
end
