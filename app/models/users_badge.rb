class UsersBadge < ApplicationRecord
  #validations
  validates :expiration, presence: true
  validates_uniqueness_of :user_id, scope: :badge

  #relationships
  belongs_to :user
  belongs_to :badge

  accepts_nested_attributes_for :badge, allow_destroy: true

  def full_name
    "#{self.user.full_name}"
  end

  def self.order_by_name
    self.joins(:user).order(:first_name)
  end

  def expiration_format
    expiration.strftime("%B %d, %Y")
  end

end
