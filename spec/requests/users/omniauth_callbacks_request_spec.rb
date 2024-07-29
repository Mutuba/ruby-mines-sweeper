require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :request do

  describe 'GET /users/auth/google_oauth2/callback' do
    before do
    end
    context 'with correct params' do
      it 'signs in the user' do
        get user_google_oauth2_omniauth_callback_path
        expect(response).to redirect_to root_path
        expect(controller.current_user).to be_present
      end
    end

    context 'with incorrect params' do
      it 'redirects user to sign in page' do
        get user_google_oauth2_omniauth_callback_path
        expect(response).to redirect_to new_user_session_path
        expect(controller.current_user).to eq nil
      end
    end
  end

end