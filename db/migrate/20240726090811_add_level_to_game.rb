class AddLevelToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :level, :integer, default: 0
  end
end
