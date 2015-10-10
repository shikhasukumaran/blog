module ApplicationHelper

	def get_guests_with_bid_number(bid_number)
		return Guest.where(bid_number: bid_number)
	end
	def get_guests_name_by_guest_id(guest_id)
		host = Guest.find(guest_id)
		return host.first_name + " " + host.last_name
	end

	def get_auction_type_heading(auction_type)
		case auction_type
		when "FUND_A_NEED"
			"Fund A Need"
		when "SILENT_AUCTION"
			"Item Purchase"
		when "MERCHANDISE"
			"Merchandise"
		when "DESSERT_DASH"
			"Dessert Dash"
		else
			"NOT KNOWN"
		end
	end

	def get_auction_by_id(auction_id)
		return Auction.find(auction_id)
	end

	def get_donation_by_guest_id(guest_id)
		return Auction.where(donor_id: guest_id).reorder('name')
	end

	def get_invoice_entries_by_auction_type(invoice_id)
		invoice_entries_by_auction_type_hash = Hash.new {|h,atype| h[atype]=[]}
		result_ies = InvoiceEntry.where(invoice_id: invoice_id).reorder('auction_type')
		result_ies.each do |result_ie|
			invoice_entries_by_auction_type_hash[result_ie.auction_type] << result_ie
		end
		return invoice_entries_by_auction_type_hash
	end

	def float_or_zero(amount)
		if amount.blank?
		 return Float(0)
		end
		Float(amount)
	rescue ArgumentError
		Float(0)
	end
end
