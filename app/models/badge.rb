class Badge < ApplicationRecord
    #validates the experation is in the future
    validates :issuer,  presence: true
    validates :name, presence: true
    validates_uniqueness_of :name, scope: :issuer

    #relationships
    has_many :users_badges
    has_many :users, through: :users_badges


end
