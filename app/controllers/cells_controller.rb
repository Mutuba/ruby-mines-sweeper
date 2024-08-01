# app/controllers/cells_controller.rb
class CellsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_up_cell

  def update
    result = CellRevealService.call(cell: @cell)
    redirect_to @cell.game
  end

  def flag    
    @cell.flag!
    redirect_to @cell.game
  end

  private def set_up_cell
    @cell = current_user.games.find(params[:game_id]).cells.find(params[:id])
  end
end
