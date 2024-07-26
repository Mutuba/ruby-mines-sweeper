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
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email  }
    password { 'SecretPassword123' }
  end
end
