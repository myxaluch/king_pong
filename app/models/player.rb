class Player < ApplicationRecord
  validates :name, presence: true

  before_save :recount_weight

  scope :by_weight, -> { order(weight: :desc) }

  alias_attribute :rating, :weight

  def games(only_wins: false)
    if only_wins
      ::Game.completed.where(winner: self)
    else
      ::Game.completed.where('player_one_id = ? OR player_two_id = ?', id, id)
    end
  end

  def last_rivals(count: 2)
    games(only_wins: false).order(:updated_at).map do |game|
      game.winner == self ? game.loser : game.winner
    end.last(count)
  end

  private

  def recount_weight
    self.weight = (win_games_count - lose_games_count + win_balls_average - lose_balls_average) / 4
  end
end
