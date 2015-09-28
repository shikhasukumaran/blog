class Guest < ActiveRecord::Base
	has_many :bids, dependent: :destroy

	validates	:first_name, presence: true, length: {maximum: 80}
	validates	:last_name, presence: true, length: {maximum: 80}
	validates   :bid_number, uniqueness: true
	validates   :email, presence: true
end
