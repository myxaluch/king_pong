class AddRatingToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :rating, :integer, null: false, default: 0
    change_column :players, :weight, :integer, null: false, default: 0
  end
end
