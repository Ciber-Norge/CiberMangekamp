class Event < ActiveRecord::Base
  belongs_to :season
  has_many :participants
  has_many :results
end
