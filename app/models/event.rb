class Event < ActiveRecord::Base
  belongs_to :season
  belongs_to :category
  has_many :participants, :dependent => :destroy
  has_many :results, :dependent => :destroy

  accepts_nested_attributes_for :results

  default_scope -> { order('date ASC') }
end
