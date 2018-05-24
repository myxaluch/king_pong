class Games::RecountWeight
  include Interactor

  delegate :game, to: :context
  delegate :winner, :loser, to: :game

  def call
    if winner.weight < loser.weight
      game_weight = ((loser.weight - winner.weight) + 5) / 3
      winner.weight += game_weight
      update_loser_weight(game_weight)
    else
      case (winner.weight - loser.weight)
      when 0..2
        winner.weight += 2
        update_loser_weight(2)
      when 2..20
        winner.weight += 1
        update_loser_weight(1)
      end
    end

    winner.save!
    loser.save!
  end

  private

  def update_loser_weight(value)
    difference = loser.weight - value

    if difference >= 0
      loser.weight -= value
    else
      loser.weight = 0
    end
  end
end
