class Event < ActiveRecord::Base
	has_many :auctions, :dependent => :destroy
	has_many :guests, :dependent => :destroy
end
