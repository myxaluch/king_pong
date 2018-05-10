# == Schema Information
#
# Table name: players
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  total_games_count  :integer          default(0), not null
#  win_games_count    :integer          default(0), not null
#  lose_games_count   :integer          default(0), not null
#  win_balls_average  :float(24)        default(0.0), not null
#  lose_balls_average :float(24)        default(0.0), not null
#  weight             :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  balls_count        :float(24)        default(0.0), not null
#  rating             :integer          default(0), not null
#

class Player < ApplicationRecord
  validates :name, presence: true

  scope :by_weight, -> { order(weight: :desc) }

  def games(only_wins: false)
    if only_wins
      ::Game.completed.where(winner: self)
    else
      ::Game.where('player_one_id = ? OR player_two_id = ?', id, id)
    end
  end

  def last_rivals(count: 2)
    games(only_wins: false).order(:updated_at).map do |game|
      game.player_one == self ? game.player_two : game.player_one
    end.last(count)
  end
end
