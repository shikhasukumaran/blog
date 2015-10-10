class Event < ActiveRecord::Base
	has_many :auctions, :dependent => :destroy
	has_many :guests, :dependent => :destroy
	has_many :bid_numbers, :dependent => :destroy
end
