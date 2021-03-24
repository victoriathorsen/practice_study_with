class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true, :if => Proc.new { new_record? || !email.nil? }
    validates :password, presence:true, length: {minimum: 6}, :if => Proc.new { new_record? || !password.nil? }
    # validates :current_school, optional: true

    belongs_to :school, optional: true
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :commented_posts, through: :comments, source: :post

    # has_many :subjects through: :posts

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
            user.provider = auth.provider
            user.username = auth.info.name
            user.email = auth.info.email
            user.password = SecureRandom.hex
        end
    end

end
