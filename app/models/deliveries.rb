class Deliveries < ActiveRecord::Base
    belongs_to :user
    validates :name, :address, :content, presence: true
end