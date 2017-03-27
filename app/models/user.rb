class User < ApplicationRecord
  has_many :participants

  default_scope -> { order('name ASC') }
  scope :retired, -> { where('retired = ?', false) }
  scope :men, -> { where(sex: 'man', retired: false) }
  scope :women, -> { where(sex: 'woman', retired: false) }

  def man?
    self.sex == 'man'
  end

  def woman?
    not man?
  end
end
