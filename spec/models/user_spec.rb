# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  uid                    :string
#  provider               :string
#  full_name              :string
#  avatar_url             :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # Association tests

  it { should have_many(:games).dependent(:destroy) }

  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('userexample.com').for(:email) }

  it "authenticates with a valid email and password" do
    user = User.create(email: "user@example.com", password: "password")
    expect(user.valid_password?("password")).to be_truthy
  end


  it "creates a user from omniauth data" do
    auth = OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '12345', info: { email: 'user@example.com', name: 'User Name', image: 'image_url' })
    user = User.from_omniauth(auth)
    expect(user.email).to eq('user@example.com')
    expect(user.full_name).to eq('User Name')
    expect(user.avatar_url).to eq('image_url')
  end
end
