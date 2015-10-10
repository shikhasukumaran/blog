module AuctionsHelper

	def guests_for_donor_select
		Guest.all.collect {|m| [m.first_name + " " + m.last_name, m.id]} 
	end

	def guest_name_by_id(guest_id)
		guest = Guest.find(guest_id)
		if !guest.blank?
			guest.first_name + " " +guest.last_name
		else
			return ""
		end
	end

	def guest_name_by_bid_number(bid_number)
		guest = Guest.where(bid_number: bid_number)
		if !guest.blank? 
			guest.first_name + " " +guest.last_name
		else
			return ""
		end
	end
end
