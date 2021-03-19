class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    # belongs_to :subject
    belongs_to :school
end
