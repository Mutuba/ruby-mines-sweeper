class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :rows
      t.integer :cols
      t.integer :mine_count
      t.string :state

      t.timestamps
    end
  end
end
