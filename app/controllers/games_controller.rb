class GamesController < ApplicationController
  def index
    @games = filtered_games.order(updated_at: :desc)
  end

  def show
    @game = Game.find_by! id: params[:id]
  end

  def create
    result = Games::Create.call(active_players: active_players_ids)

    if result.success?
      redirect_to games_path
    else
      flash[:danger] = result.error
      redirect_to root_path
    end
  end

  def update
    result = Games::Complete.call(player_points.merge(game: Game.find(params[:id])))

    if result.success?
      flash[:success] = 'Game complete!'
    else
      flash[:danger] = result.error
    end

    redirect_to games_path
  end

  private

  def basic_relation
    Game.active.any? ? Game.active : Game.all
  end

  def filtered_games
    player = Player.find_by(name: filter_params)
    player.present? ? basic_relation.by_player(player) : basic_relation
  end

  def filter_params
    return unless params[:player_filter].present?

    params.require(:player_filter)
  end

  def active_players_ids
    params.fetch(:players_ids, {}).keys.map(&:to_i)
  end

  def player_points
    {
      player_one_points: params[:player_one_points].to_i,
      player_two_points: params[:player_two_points].to_i
    }
  end
end
