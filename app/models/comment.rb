class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    

    def formated_created_at
        self.created_at.strftime("%A %b %d / %Y at %H:%M %p")
    end

end
