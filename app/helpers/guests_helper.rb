module GuestsHelper

	def guests_of_event(event)
		Guest.where(event_id: event.id).collect {|m| [m.first_name + " " + m.last_name, m.id]} 
	end

	def get_bid_number_by_number_value(bid_number)
		if bid_number.blank?
			return nil
		else 
			BidNumber.where(bid_number: bid_number).first
		end
	end

	def get_guests_by_bid_number(bid_number)
		return Guest.where(bid_number: bid_number)
	end
end
