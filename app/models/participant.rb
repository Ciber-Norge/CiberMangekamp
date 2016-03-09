class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :result, :dependent => :destroy

  default_scope -> { joins(:user).order('name ASC') }
  scope :men, -> { joins(:user).where('users.sex = ?', 'man') }
  scope :women, -> { joins(:user).where('users.sex = ?', 'woman') }
end
