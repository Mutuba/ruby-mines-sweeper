# app/services/cell_reveal_service.rb
class CellRevealService < ApplicationService
  Result = Struct.new(:success?, :failure?)

  def initialize(**args)
    super() # the parent doesn't take any arguments from child
    @cell = args.fetch(:cell, nil)
  end

  def call
    return success_result if @cell.nil? || @cell.revealed?

    game = @cell.game

    ActiveRecord::Base.transaction do
      @cell.update!(revealed: true)
      if @cell.mine?
        game.update!(state: :lost)
        return success_result
      end

      if @cell.adjacent_mines.zero?
        game.neighboring_cells(@cell).each do |neighboring_cell|
          neighboring_cell.update!(revealed: true) unless neighboring_cell.revealed?
        end
      end
      check_win_condition(game)
    end
    success_result
  rescue StandardError, ActiveRecord::Rollback => e
    failure_result
    Rails.logger.info "An error occurred #{e.message}"
  end

  private

  def success_result
    Result.new(true, false)
  end

  def failure_result
    Result.new(false, true)
  end

  def check_win_condition(game)
    if game.cells.where(mine: false, revealed: false).empty?
      game.update!(state: :won)
    end
  end
end