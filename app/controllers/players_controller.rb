class PlayersController < ApplicationController
  def index
    @players = Player.all.by_weight
  end

  def show
    @player = Player.find_by! id: params[:id]
  end

  def create
    player = Player.create! name: params[:name]

    redirect_to players_path
  end

  def destroy
    player = Player.find(params[:id])
    player.destroy!

    redirect_to players_path
  end
end
