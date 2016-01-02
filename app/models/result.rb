class Result < ActiveRecord::Base
  belongs_to :participant

  default_scope {
    order('rank ASC')
  }
end
