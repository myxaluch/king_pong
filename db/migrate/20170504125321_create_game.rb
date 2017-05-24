class CreateGame < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :player_one
      t.references :player_two
      t.references :winner
      t.references :loser
      t.string :state
      t.integer :winner_points, default: 0
      t.integer :loser_points, default: 0

      t.timestamps null: false
    end
  end
end
