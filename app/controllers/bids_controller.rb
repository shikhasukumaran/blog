class BidsController < ApplicationController

	def destroy
		puts params.inspect
	    @auction = Auction.find(params[:auction_id])
	    @bid = @auction.bids.find(params[:id])
	    @bid.destroy
	    redirect_to auction_path(@auction), notice: "Bid is successfully deleted!"
  	end
end
