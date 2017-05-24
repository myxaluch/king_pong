class Games::Complete
  include Interactor

  delegate :game, :player_one_points, :player_two_points, to: :context

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

    game.complete!
  end
end
