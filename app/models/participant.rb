class Participant < ActiveRecord::Base
  belongs_to :user, :event
  has_one :result
end
