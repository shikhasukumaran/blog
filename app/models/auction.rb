class Auction < ActiveRecord::Base
	belongs_to :event
	has_many :bids, :dependent => :destroy

	validates	:name, presence: true, uniqueness: true, length: {maximum: 80}
end
