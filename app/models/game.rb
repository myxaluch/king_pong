class Game < ApplicationRecord
  include AASM

  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :loser, class_name: 'Player', optional: true

  aasm :state do
    state :active, initial: true
    state :completed

    event :complete, after: :update_players_stats do
      transitions to: :completed
    end
  end

  scope :active, -> { where(state: :active) }

  private

  def update_players_stats
    winner.win_games_count += 1
    winner.total_games_count += 1
    winner.win_balls_average = (winner.win_balls_average + winner_points) / winner.total_games_count
    winner.lose_balls_average = winner.lose_balls_average / winner.total_games_count
    winner.save!

    loser.lose_games_count += 1
    loser.total_games_count += 1
    loser.lose_balls_average = (loser.lose_balls_average + loser_points) / loser.total_games_count
    loser.win_balls_average = loser.win_balls_average / loser.total_games_count
    loser.save!
  end
end
