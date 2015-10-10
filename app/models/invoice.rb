class Invoice < ActiveRecord::Base
	belongs_to :bid_number
	has_many :invoice_entries , dependent: :destroy
	
end
