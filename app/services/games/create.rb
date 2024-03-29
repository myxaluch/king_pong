class Games::Create
  include Interactor

  RIVALS_COUNT = 3

  delegate :active_players, to: :context

  def call
    new_games = find_rivals.map do |hash_rivals|
      Game.create! player_one: hash_rivals[:player_one], player_two: hash_rivals[:player_two]
    end

    context.games = new_games
  end

  private

  def find_rivals
    generate_active_players.each_slice(2).map do |first, second|
      {
        player_one: ::Player.find(first),
        player_two: ::Player.find(second)
      }
    end
  end

  def generate_active_players
    context.fail!(error: 'Выберете больше одного игрока') if active_players.size < 2
    active_players << active_players.sample if active_players.size % 2 == 1

    @correct_active_players = active_players.shuffle
    while @correct_active_players.each_slice(2).select { |first, second|
            (first == second) || (::Player.find(first).last_rivals(count: RIVALS_COUNT).map(&:id).include?(second))
          }.any?

      @correct_active_players = active_players.shuffle
    end

    @correct_active_players
  end
end
