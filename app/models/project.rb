class Project < ApplicationRecord
    has_many :schedules
    has_many :users, through: :schedules

    validates :name, presence: true, uniqueness: true
    validates :address, presence: true
    validates :project_number, presence: true
    validates :construction_type, presence: true, inclusion: {in: ['New Construction', 'Tenent']}

    def start_time_format
        self.start_date.strftime("%B %d, %Y")
    end

    def end_time_format
        self.end_date.strftime("%B %d, %Y")
    end
end
