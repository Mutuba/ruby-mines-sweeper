# Error module to handle errors globally
module Error
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      class GameErrorException < StandardError; end

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from GameErrorException, with: :game_error
    end

    private

    def game_error(message)
      respond_to do |format|
        format.html do
          render 'errors/game_error', status: :unprocessable_entity, locals: { message: message }
        end
      end
    end

    def record_invalid(_e)
      resource_type = identify_resource_type(_e)
      respond_to do |format|
        format.html do
          render 'errors/record_invalid', status: :unprocessable_entity, locals: { resource_type: resource_type }
        end
      end
    end

    def record_not_found(_e)
      resource_type = identify_resource_type(_e)
      respond_to do |format|
        format.html do
          render 'errors/404', status: :not_found, locals: { resource_type: resource_type }
        end
      end
    end

    def identify_resource_type(exception)
      case exception.message
      when /Game/
        'Game'
      when /Cell/
        'Cell'
      else
        'Resource'
      end
    end
  end
end
