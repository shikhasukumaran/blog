class BidsController < ApplicationController


	def destroy
	    @auction = Auction.find(params[:auction_id])
	    if(@auction.status == "OPEN")
		    @bid = @auction.bids.find(params[:id])
		    @bid.destroy
		    redirect_to auction_path(@auction), notice: "Bid is successfully deleted!"
		else
			redirect_to auction_path(@auction), notice: "Reopen the auction!"
		end

  	end
  	
end
