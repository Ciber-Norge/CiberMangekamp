class Event < ActiveRecord::Base
  belongs_to :season
  has_many :participants
  has_many :results

  accepts_nested_attributes_for :results
end
