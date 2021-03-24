class Post < ApplicationRecord
    belongs_to :school
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :users, through: :comments

    def formated_created_at
        self.created_at.strftime("%A %b %d / %Y at %H:%M %p")
    end
end
