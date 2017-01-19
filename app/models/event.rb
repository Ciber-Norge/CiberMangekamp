class Event < ActiveRecord::Base
  belongs_to :season
  belongs_to :category
  has_many :participants, :dependent => :destroy

  default_scope -> { order('date ASC') }
end
