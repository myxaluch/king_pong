class Games::Complete
  include Interactor

  delegate :game, :player_one_points, :player_two_points, to: :context
  delegate :winner, :loser, to: :game

  def call
    if player_one_points > player_two_points
      game.winner = game.player_one
      game.winner_points = player_one_points
      game.loser = game.player_two
      game.loser_points = player_two_points
    else
      game.winner = game.player_two
      game.winner_points = player_two_points
      game.loser = game.player_one
      game.loser_points = player_one_points
    end

    update_players_stats!

    game.complete!

    Games::RecountWeight.call(game: game)
  end

  private

  def update_players_stats!
    winner.win_games_count += 1
    winner.total_games_count += 1
    winner.win_balls_average = (winner.win_balls_average + game.winner_points) / winner.total_games_count
    winner.lose_balls_average = winner.lose_balls_average / winner.total_games_count
    winner.save!

    loser.lose_games_count += 1
    loser.total_games_count += 1
    loser.lose_balls_average = (loser.lose_balls_average + game.loser_points) / loser.total_games_count
    loser.win_balls_average = loser.win_balls_average / loser.total_games_count
    loser.save!
  end
end
