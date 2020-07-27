class Helper < ApplicationRecord
  validates :user_id, presence: true

  #associations
  belongs_to :user
  belongs_to :foreman

  #nested form association
  accepts_nested_attributes_for :user,  allow_destroy: true


  def full_name
    "#{self.user.first_name} #{self.user.last_name}"
  end

end
