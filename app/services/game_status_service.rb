# app/services/game_status_service.rb
class GameStatusService < ApplicationService
  def initialize(**args)
    super()
    @game = args[:game]
  end

  def call
    check_modifiable!
  end

  def check_modifiable!
    raise GameErrorException, "You cannot play a lost game." if @game.lost?
  end
end
