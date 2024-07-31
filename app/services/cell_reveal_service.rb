# app/services/cell_reveal_service.rb
class CellRevealService < ApplicationService
  def initialize(**args)
    super()
    @cell = args.fetch(:cell, nil)
  end

  def call
    return if @cell.nil? || @cell.revealed?
   
    game = @cell.game
    @cell.update(revealed: true)
        
    if @cell.mine?
      game.update(state: :lost)
      return
    end

    if @cell.adjacent_mines.zero?
      game.neighboring_cells(@cell).each do |neighboring_cell|
        neighboring_cell.update(revealed: true) unless neighboring_cell.revealed?
      end
    end
   
    game.check_win_condition
  end
end
