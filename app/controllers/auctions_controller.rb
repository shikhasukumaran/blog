class AuctionsController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@auctions = Auction.where(event_id: params[:event_id]).order('status')
	end

	def new
		@event = Event.find(params[:event_id])
		@auction = @event.auctions.build
		@auction.status = "OPEN"	
	end

	def edit
    	@auction = Auction.find(params[:id])
    	@event = Event.find(@auction.event_id)
	end
      
	def create
		@event = Event.find(params[:event_id])
		@auction = @event.auctions.build(auction_params)

		if @auction.auction_type == "FUND_A_NEED" && @auction.auction_type == "DESSERT_DASH"
			@auction.fair_market_value = 0
		end

		@auction.save
		if @auction && @auction.errors.any? 
			render 'edit'
		else
			redirect_to event_auctions_path(@event)
		end
	end

    def update
    	@error_msg  = nil
	    @auction = Auction.find(params[:id])
	    #DEBUG
	 	puts params.inspect

	 	if params[:auction][:bid_update] && params[:auction][:bid_update] == "TRUE"
	 		# Update is coming from Bids update page for an Auction.
	 		bid_count = Integer(params[:auction][:bid_count])
	 		1.upto(bid_count) do |x|
	 			x_str = x.to_s
	 			if params[:auction][x_str]
	 				bid_number_var = params[:auction][x_str][:bid_number]
	 				bid_amount_var = params[:auction][x_str][:bid_amount]
	 				quantity_purchased_var = params[:auction][x_str][:quantity_purchased]

					if is_valid_bid_params(bid_number_var, bid_amount_var, quantity_purchased_var)
						@guest = Guest.where(bid_number: bid_number_var)
						if !@guest.blank?
							if @auction.auction_type == "MERCHANDISE"
								bid_amount_real = @auction.fair_market_value * Integer(quantity_purchased_var)
								@auction.bids.build(:bid_number => bid_number_var.strip , :bid_amount => bid_amount_real, :quantity_purchased => quantity_purchased_var.strip)
							else
								@auction.bids.build(:bid_number => bid_number_var.strip , :bid_amount => bid_amount_var.strip, :quantity_purchased => 1)		
							end
						else
							@error_msg = "Invalid Bid Number Used"
						end
					end
				end
	 		end
	 		Auction.transaction do
	 			@auction.save
	 		end
	 		redirect_to auction_path(@auction), notice: "Bids are successfully updated!"
	 	else
	 		bids_to_update = []
	 		# Is Auction being closed Open -> Close
	 		if @auction.status == "OPEN" && params[:auction][:status] == "CLOSED"
	 			auction_type = @auction.auction_type
	 			max_bid_amount = 0
	 			max_bid = nil

	 			if @auction.auction_type == "SILENT_AUCTION"
		 			@auction.bids.each do |auction_bid|
		 				puts auction_bid.inspect
		 				if auction_bid.bid_amount > max_bid_amount
		 					max_bid_amount = auction_bid.bid_amount
		 					max_bid = auction_bid
		 				end
		 			end
		 			if !max_bid.blank?
		 				max_bid.is_winner = true
		 				bids_to_update << max_bid
		 			end
	 			else
	 				@auction.bids.each do |auction_bid|
	 					auction_bid.is_winner = true
	 					bids_to_update << auction_bid
	 				end
	 			end
	 		end
	 		# Is Auction being Reopened Close -> Open
	 		if @auction.status == "CLOSED" && params[:auction][:status] == "OPEN"
	 			auction_type = @auction.auction_type
	 			@auction.bids.each do |auction_bid|
	 				if auction_bid.is_winner
	 					bids_to_update << auction_bid
	 				end
	 				auction_bid.is_winner = nil
	 			end
	 		end
			success_update = false
			success_save = false
			Auction.transaction do
				success_update = @auction.update_attributes(auction_params)
				success_save = @auction.save
				bids_to_update.each do |bid_to_update|
					bid_to_update.save
				end
			end
			if success_update && success_save
		    	redirect_to auction_path(@auction), notice: "Auction is successfully updated!"
		    else
		      	render 'edit'
		    end
		end
  	end

  	def show
    	@auction = Auction.find(params[:id])
    	@event = Event.find(@auction.event_id)
    	@bids = @auction.bids
  	end

  	def destroy
	    @event = Event.find(params[:event_id])
	    @auction = @event.auctions.find(params[:id])
	    @auction.destroy
	    redirect_to event_auctions_path(@event), notice: "Auction is successfully deleted!"
  	end

  	def upload_auctions(file_name)
  		
  	end

	private
	  def auction_params
	    params.require(:auction).permit(:name, :description, :auction_type, :donor_id,:fair_market_value, :winning_bid_number, :status)
	  end

	  def is_valid_bid_params(bid_number, bid_amount, quantity_purchased)
	  	if !bid_number.blank?
	  		if !bid_amount.blank? 
	  			return integer_or_nil(bid_number) && float_or_nil(bid_amount)
	  		end
	  		if !quantity_purchased.blank?
	  			return  integer_or_nil(bid_number) && integer_or_nil(quantity_purchased)
	  		end
	  	end
	  	return false
	  end

	  def integer_or_nil(string)
  		Integer(string.strip || '')
	  rescue ArgumentError
  		nil
	  end

	  def float_or_nil(string)
	  	Float(string.strip || '')
	  rescue ArgumentError
	  	nil
	  end

end


