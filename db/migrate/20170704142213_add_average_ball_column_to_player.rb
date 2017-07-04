class AddAverageBallColumnToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :balls_count, :float, null: false, default: 0
  end
end
