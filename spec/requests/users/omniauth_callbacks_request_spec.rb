require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :request do

  describe 'log in with valid auth' do
    before do
      OmniAuth.config.add_mock(:google_oauth2, {
        provider: 'google_oauth2',
        uid: '123456',
        info: { email: 'fakegmail@gmail.com' }
      })
    end

    it 'signs in the user' do
      get user_google_oauth2_omniauth_callback_path
      expect(response).to redirect_to root_path        
      expect(controller.current_user).to be_present
    end
  end

  describe 'log in with invalid auth' do    
    it 'redirects user to sign in page' do
      get user_google_oauth2_omniauth_callback_path
      expect(response).to redirect_to new_user_session_path
      expect(controller.current_user).to eq nil
    end
  end
end