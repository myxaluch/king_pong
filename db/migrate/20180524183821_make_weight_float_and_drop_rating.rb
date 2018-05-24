class MakeWeightFloatAndDropRating < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :rating
    change_column :players, :weight, :float, null: false, default: 0
  end
end
