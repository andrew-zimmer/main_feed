class Foreman < ApplicationRecord
  belongs_to :user
  has_many :helpers
end
