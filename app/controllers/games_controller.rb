class GamesController < ApplicationController
  def index
    @games = params[:active].present? ? Game.active : Game.all
  end

  def show
    @game = Game.find_by! id: params[:id]
  end

  def create
    result = Games::Create.call(active_players: active_players_ids)

    if result.success?
      redirect_to games_path(active: true)
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

    Game.active.any? ? redirect_to(games_path(active: true)) : redirect_to(games_path)
  end

  private

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
