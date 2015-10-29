class User < ActiveRecord::Base
  has_many :participants
end
