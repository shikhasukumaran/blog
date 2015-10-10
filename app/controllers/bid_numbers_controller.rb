class BidNumbersController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@bid_numbers = BidNumber.where(event_id: params[:event_id])
	end

	def new
		@event = Event.find(params[:event_id])
		@bid_number = @event.bid_numbers.build
	end


	def edit
    	@bid_number = BidNumber.find(params[:id])
    	@event = Event.find(@bid_number.event_id)
	end

	def show
    	@bid_number = BidNumber.find(params[:id])
    	@event = Event.find(@bid_number.event_id)
  	end

  	def update
	    @bid_number = BidNumber.find(params[:id])
 
	    if @bid_number.update(bid_number_params)
	      redirect_to @bid_number
	    else
	      render 'edit'
	    end
  	end

	def create
		@event = Event.find(params[:event_id])
		@bid_number = @event.bid_numbers.build(bid_number_params)
		@bid_number.event_due_amount = 0
		@bid_number.event_due_pay_status = "UNPAID"
		@bid_number.invoice_email_status = "NOT_SENT"
		@bid_number.save
		if @bid_number && @bid_number.errors.any? 
			render 'edit'
		else
			redirect_to event_bid_numbers_path(@event)
		end
	end

	def destroy
	    @event = Event.find(params[:event_id])
	    @bid_number = @event.bid_numbers.find(params[:id])
	    @guests = Guest.where(bid_number: @bid_number.bid_number)
	    if @guests.blank?
	    	@bid_number.destroy
	    end
	    redirect_to event_bid_numbers_path(@event), notice: "Bid number will be deleted if not assigned to a guest"
  	end

	private
	  def bid_number_params
	    params.require(:bid_number).permit(:bid_number, :fee_adjustment)
	  end
end
