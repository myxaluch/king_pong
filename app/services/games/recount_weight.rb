class Games::RecountWeight
  include Interactor

  delegate :game, to: :context
  delegate :winner, :loser, to: :game

  def call
    if winner.weight < loser.weight
      game_weight = ((loser.weight - winner.weight) + 5) / 3
      winner.weight += game_weight
      loser.weight -= game_weight
    else
      case (winner.weight - loser.weight)
      when 0..2
        winner.weight += 2
        loser.weight -= 2
      when 2..20
        winner.weight += 1
        loser.weight -= 1
      end
    end

    winner.save!
    loser.save!
  end
end
