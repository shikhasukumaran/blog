class InvoicesController < ApplicationController
 

 def index
  	
 end

 def create

 end

 def edit
    @invoice = Invoice.find(params[:id])
    @bid_number = BidNumber.find(@invoice.bid_number_id)
 end

 def new
	@bid_number = BidNumber.find(params[:bid_number_id])
	bid_number = @bid_number.bid_number

	# Get invoices to get the max version number.
	max_version = 0
	@bid_number.invoices.each do |invoice|
		if invoice.version && invoice.version > max_version
			max_version = invoice.version 
		end
	end
	max_version = max_version + 1

	# Create invoice and invoice entries from winner bids made by the bid_number.
	Invoice.transaction do 
		@invoice = @bid_number.invoices.build
		@invoice.version = max_version
		# TODO create status field @invoice.status = "CREATED"
		# Get bids for this bid_number that are winners.
		sum_due_amount = 0
		Bid.where("bid_number = :bid_number AND is_winner = :is_winner", {bid_number: bid_number, is_winner: true}).find_each do |bid|
			auction = Auction.find(bid.auction_id)
			invoice_entry = @invoice.invoice_entries.build(:auction_id => bid.auction_id, :auction_type => auction.auction_type, :bid_id => bid.id, :bid_amount => bid.bid_amount, :quantity_purchased => bid.quantity_purchased)
			
			sum_due_amount += bid.bid_amount
			@bid_number.event_due_amount = sum_due_amount
			@bid_number.save

			invoice_entry.save
		end
		@invoice.save
	end

	render 'show'
 end

def show
    @invoice = Invoice.find(params[:id])
	@bid_number = BidNumber.find(@invoice.bid_number_id)
end

def update

    @invoice = Invoice.find(params[:id])
    @bid_number = BidNumber.find(@invoice.bid_number_id)
    
    if params[:invoice][:status] == "PAID"
    	@bid_number.event_due_pay_status = "PAID"
    	@bid_number.invoice_email_status = nil
    end
    if params[:invoice][:status] == "PAID_EMAILED"
    	@bid_number.event_due_pay_status = "PAID"
    	@bid_number.invoice_email_status = "EMAILED"
    	UserMailer.send_invoice_email(@invoice).deliver
    end
    if params[:invoice][:status] == "NONE"
    	@bid_number.event_due_pay_status = nil
    	@bid_number.invoice_email_status = nil
    end
    save_invoice  = true
    save_bid_number = true
    Invoice.transaction do
	    # If being updated to PAID and EMAILED send an email.
	    save_invoice = @invoice.update(invoice_params) 
	    save_bid_number = @bid_number.save

	end
	if save_invoice && save_bid_number
	    redirect_to  bid_number_invoice_path(@bid_number, @invoice), notice: "Invoice updated"
    else
      render 'edit'
    end
end

def destroy
	@bid_number = BidNumber.find(params[:bid_number_id])
	@invoice = @bid_number.invoices.find(params[:id])
	@invoice.destroy
	redirect_to bid_number_path(@bid_number), notice: "Invoice is successfully deleted!"
end
private
	def invoice_params
		params.require(:invoice).permit(:status)
	end
end
