# app/services/cell_reveal_service.rb
class CellRevealService
  def initialize(cell)
    @cell = cell
    @game = cell.game
  end

  def call
    return if @cell.revealed?

    @cell.update(revealed: true)
    @game.update(state: :lost) if @cell.mine?

    if @cell.adjacent_mines.zero?      
      @game.neighboring_cells(@cell).each do |cell|
        cell.update(revealed: true) unless cell.revealed?
      end
    end

    @game.check_win_condition
  end
end
