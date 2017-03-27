class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :by_name, -> { joins(:user).order('name ASC') }
  scope :men, -> { joins(:user).where('users.sex = ?', 'man').order('rank ASC') }
  scope :women, -> { joins(:user).where('users.sex = ?', 'woman').order('rank ASC') }
end
