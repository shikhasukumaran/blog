class BidNumber < ActiveRecord::Base
	belongs_to :event
	has_many :invoices, :dependent => :destroy
end
