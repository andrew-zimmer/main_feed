class Helper < ApplicationRecord
  validates :user_id, presence: true
  validates :foreman_id, presence: false

  #associations
  belongs_to :user
  belongs_to :foreman

  #nested form association
  accepts_nested_attributes_for :user,  allow_destroy: true


  def full_name
    "#{self.user.first_name} #{self.user.last_name}"
  end

  def email
    user.email
  end

  def phone_number
    user.phone_number
  end

  def users_badges
    user.users_badges
  end


end
