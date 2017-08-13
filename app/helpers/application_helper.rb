module ApplicationHelper
  def correct_active_class(path)
    'activated_link' if path == request.path
  end

  def games_dates(games)
    games.map { |game| game.updated_at.strftime('%d/%m/%Y') }.uniq
  end

  def correct_balls_count_for(player)
    player.total_games_count.zero? ? 0 : (player.balls_count / player.total_games_count).round(2)
  end

  def winner_place_colors(index)
    if Game.completed.count > 10
      case index
        when 0
          'place first-place'
        when 1
          'place second-place'
        when 2
          'place third-place'
        else
          ''
        end
      end
  end

  def list_of_players
    Player.select(:name).pluck(:name)
  end
end
