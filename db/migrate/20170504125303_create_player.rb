class CreatePlayer < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :total_games_count, null: false, default: 0
      t.integer :win_games_count, null: false, default: 0
      t.integer :lose_games_count, null: false, default: 0
      t.float :win_balls_average, null: false, default: 0
      t.float :lose_balls_average, null: false, default: 0
      t.float :weight, null: false, default: 0

      t.timestamps null: false
    end
  end
end
