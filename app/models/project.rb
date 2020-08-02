class Project < ApplicationRecord
    has_many :schedules
    has_many :users, through: :schedules

    validates :name, presence: true, uniqueness: true
    validates :address, presence: true
    validates :project_number, presence: true, numericality: true
    validates :construction_type, presence: true, inclusion: {in: ['New Construction', 'Tenent']}
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :start_date_is_not_in_past, :end_date_is_not_before_start_date

    def start_time_format
        self.start_date.strftime("%B %d, %Y")
    end

    def end_time_format
        self.end_date.strftime("%B %d, %Y")
    end

    #validators
    def start_date_is_not_in_past
        if start_date.present? && start_date < Date.today
            errors.add(:start_date, "can't be in the past")
        end
    end

    def end_date_is_not_before_start_date
        if start_date > end_date
            errors.add(:end_date, "can't be set before start date")
        end
    end
end
