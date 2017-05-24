class Player < ApplicationRecord
  validates :name, presence: true

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
end
