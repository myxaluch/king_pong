class IndexController < ApplicationController
  # main page
  def index
    @players = Player.all
  end
end
