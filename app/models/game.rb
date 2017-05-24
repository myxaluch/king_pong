class Game < ApplicationRecord
  include AASM

  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :loser, class_name: 'Player', optional: true

  aasm :state do
    state :active, initial: true
    state :completed

    event :complete do
      transitions to: :completed
    end
  end

  scope :active, -> { where(state: :active) }
end
