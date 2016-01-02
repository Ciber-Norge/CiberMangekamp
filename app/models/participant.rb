class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :result, :dependent => :destroy
end
