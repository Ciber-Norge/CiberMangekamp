class Result < ActiveRecord::Base
  belongs_to :participant

  default_scope -> { order('rank ASC') }
  scope :men, -> { joins(:participant).merge(Participant.men) }
  scope :women, -> { joins(:participant).merge(Participant.women) }
end
