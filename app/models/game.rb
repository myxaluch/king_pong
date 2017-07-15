class Game < ApplicationRecord
  include AASM

  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :loser, class_name: 'Player', optional: true

  scope :by_date, lambda { |date|
    where(updated_at: DateTime.parse(date).beginning_of_day..DateTime.parse(date).end_of_day)
  }

  aasm :state do
    state :active, initial: true
    state :completed

    event :complete do
      transitions to: :completed
    end
  end
end
