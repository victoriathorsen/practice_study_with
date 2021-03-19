class School < ApplicationRecord
    has_many :users
    has_many :posts, dependent: :destroy
    # has_many :subjects 
end
