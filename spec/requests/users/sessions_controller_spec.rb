require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do

  describe 'User logs out successfully' do
    before do
      OmniAuth.config.add_mock(:google_oauth2, { provider: 'google_oauth2', uid: '12345', info: { email: 'test@example.com'} })
      get user_google_oauth2_omniauth_callback_path
    end

    it 'logs out successfully' do
      delete destroy_user_session_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end