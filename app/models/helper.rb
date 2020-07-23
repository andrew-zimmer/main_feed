class Helper < ApplicationRecord

  #associations
  belongs_to :user
  belongs_to :foreman

  #nested form association
  accepts_nested_attributes_for :user,  allow_destroy: true

end
