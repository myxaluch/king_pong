# == Schema Information
#
# Table name: games
#
#  id            :integer          not null, primary key
#  player_one_id :integer
#  player_two_id :integer
#  winner_id     :integer
#  loser_id      :integer
#  state         :string(255)
#  winner_points :integer          default(0)
#  loser_points  :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Game < ApplicationRecord
  include AASM

  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :loser, class_name: 'Player', optional: true

  scope :by_date, lambda { |date|
    where(updated_at: DateTime.parse(date).beginning_of_day..DateTime.parse(date).end_of_day)
  }
  scope :by_player, lambda { |player|
    id = player.id
    where('player_one_id = ? OR player_two_id = ? OR winner_id = ? OR loser_id = ?', id, id, id, id)
  }

  aasm :state do
    state :active, initial: true
    state :completed

    event :complete do
      transitions to: :completed
    end
  end
end
