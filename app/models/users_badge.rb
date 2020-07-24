class UsersBadge < ApplicationRecord
  #validations
  validates :expiration, presence: true

  #relationships
  belongs_to :user
  belongs_to :badge

  accepts_nested_attributes_for :badge, allow_destroy: true

  def full_name
    "#{self.user.full_name}"
  end
end
