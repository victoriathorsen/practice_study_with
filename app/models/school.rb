class School < ApplicationRecord
    # has_many :posts, dependent: :destroy
    has_many :users
    has_many :posts, through: :users, dependent: :destroy
    # before_save :titleize_schools
    # has_many :subjects 

    scope :alpha, -> { order(:name) }

    def self.search(search)
        if search
            school = School.find_by(name: search)
            if school
                self.where(id: school)
            else
                School.alpha
            end
        else
            School.alpha
        end
    end
  
end
