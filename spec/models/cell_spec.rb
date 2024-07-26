# == Schema Information
#
# Table name: cells
#
#  id             :bigint           not null, primary key
#  game_id        :bigint           not null
#  row            :integer
#  col            :integer
#  mine           :boolean
#  revealed       :boolean
#  flag           :boolean
#  adjacent_mines :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Cell, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
