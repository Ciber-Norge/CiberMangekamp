class User < ActiveRecord::Base
  has_many :participants

  default_scope -> { order('name ASC') }
  scope :men, -> { where(sex: 'man') }
  scope :women, -> { where(sex: 'woman') }
end
