module ApplicationHelper
  def correct_games_path
    Game.active.present? ? games_path(active: true) : games_path
  end

  def correct_active_class(path)
    'activated_link' if path == request.path
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
end
