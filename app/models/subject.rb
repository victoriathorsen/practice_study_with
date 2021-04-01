class Subject < ApplicationRecord
    has_many :posts, dependent: :destroy
    # has_many :users through: :posts

    scope :alpha, -> { order(:name) }

    def self.search(search)
        if search
            subject = Subject.find_by(name: search)
            if subject
                self.where(id: subject)
            else
                Subject.alpha
            end
        else
            Subject.alpha
        end
    end
end
