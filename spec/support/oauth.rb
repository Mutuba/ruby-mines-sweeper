RSpec.configure do |config|
  OmniAuth.config.test_mode = true
  config.after(:each) do
    OmniAuth.config.add_mock(:google_oauth2, {})
  end
end