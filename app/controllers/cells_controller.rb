# frozen_string_literal: true

# app/controllers/cells_controller.rb
class CellsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_up_cell
  before_action :check_game_status, only: %i[update flag]

  def update
    result = CellRevealService.call(cell: @cell)
    raise GameErrorException, 'An error occured. Please try again later' unless result.success?

    redirect_to @cell.game
  end

  def flag
    @cell.flag!
    redirect_to @cell.game
  end

  private

  def set_up_cell
    @cell = current_user.games.find(params[:game_id]).cells.find(params[:id])
  end

  def check_game_status
    GameStatusService.call(game: @cell.game)
  end
end
