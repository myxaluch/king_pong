class GamesController < ApplicationController
  def index
    @games = basic_relation.order(updated_at: :desc)
  end

  def show
    @game = Game.find_by! id: params[:id]
  end

  def create
    result = Games::Create.call(active_players: active_players_ids, rivals_count: rivals_count)

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

  def active_players_ids
    params.fetch(:players_ids, {}).keys.map(&:to_i)
  end

  def rivals_count
    params.fetch(:rivals_count, 2).to_i
  end

  def player_points
    {
      player_one_points: params[:player_one_points].to_i,
      player_two_points: params[:player_two_points].to_i
    }
  end
end
