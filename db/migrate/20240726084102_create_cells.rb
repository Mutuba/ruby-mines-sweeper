class CreateCells < ActiveRecord::Migration[7.1]
  def change
    create_table :cells do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :row
      t.integer :col
      t.boolean :mine
      t.boolean :revealed
      t.boolean :flag
      t.integer :adjacent_mines

      t.timestamps
    end
  end
end
