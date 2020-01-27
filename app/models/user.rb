class User < ActiveRecord::Base
    has_secure_password
    has_many :deliveries
    validates :username, :email, :password, presence: true
    validates_uniqueness_of :user name
end