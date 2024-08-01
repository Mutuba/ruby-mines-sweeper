class ApplicationController < ActionController::Base
  include Error::ErrorHandler
  protect_from_forgery with: :null_session

end
