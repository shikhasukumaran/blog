class AuctionsController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@auctions = Auction.where(params[:event_id])
	end

	def new
		@event = Event.find(params[:event_id])
		@auction = @event.auctions.build
		@auction.status = "OPEN"	
	end

	def edit
		@event = Event.find(params[:event_id])
    	@auction = @event.auctions.find(params[:id])	
	end

	def create
		@event = Event.find(params[:event_id])
		@auction = @event.auctions.create(auction_params)
		if @auction && @auction.errors.any? 
			render 'edit'
		else
			redirect_to event_auctions_path(@event)
		end
	end

    def update
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

					if is_valid_bid_params(bid_number_var, bid_amount_var)
						@auction.bids.build(:bid_number => bid_number_var.strip , :bid_amount => bid_amount_var.strip)
					end
				end
	 		end
	 		Auction.transaction do
	 			@auction.save
	 		end
	 		redirect_to auction_path(@auction), notice: "Bids are successfully updated!"
	 	else
	 		# Is Auction being closed Open -> Close

	 		# Is Auction being Reopened Close -> Open

			if @auction.update(params[:auction])
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

	private
	  def auction_params
	    params.require(:auction).permit(:name, :description, :auction_type, :donor_name,:fair_market_value, :can_multiple_bid_win, :winning_bid_number, :quantity, :status)
	  end

	  def is_valid_bid_params(bid_number, bid_amount)
	  	if !bid_number.blank? && !bid_amount.blank?
	  		is_bid_number_integer = integer_or_nil(bid_number)
	  		is_bid_amount_float = float_or_nil(bid_amount)
	  		puts is_bid_number_integer
	  		puts is_bid_amount_float
	  		if is_bid_number_integer && is_bid_amount_float
	  			return true
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


