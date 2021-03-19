class FakeUser < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true
    validates :password, presence:true
    # , length: {minimum: 6}

    belongs_to :school, optional: true
    # has_many :subjects through: :posts
    has_many :posts
    # has_many :comments
end
