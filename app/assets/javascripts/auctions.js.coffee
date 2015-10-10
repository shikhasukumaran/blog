# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
	$('#addBid').click ->
		# increment the count
		bidRowCountText = $('#bid_count').val()
		bidRowCountNew = parseInt(bidRowCountText, 10) + 1
		auction_type_hidden = $('#auction_type_hidden').val()
		# reset the count
		$('#bid_count').val(bidRowCountNew)

		# Add the new rows to the bids table
		bidRowId = "bid_row_id_"+bidRowCountNew
		remove_bid_row_id = "remove_bid_"+bidRowCountNew
		bidNumberByRow = "bidNumberByRow_"+bidRowCountNew
		bidAmountByRow = "bidAmountByRow_"+bidRowCountNew
		quantityPurchasedByRow = "quantityPurchasedByRow"+bidRowCountNew

		if auction_type_hidden == "MERCHANDISE"
			$('#bidsTable tbody').append('<tr id="'+bidRowId+'"><td><a id="'+remove_bid_row_id+'"> - </a><td><input id="'+bidNumberByRow+'" name="auction['+bidRowCountNew+'][bid_number]"></input><td><input id="'+bidAmountByRow+'" disabled name="auction['+bidRowCountNew+'][bid_amount]"></input><td><input id="'+quantityPurchasedByRow+'" name="auction['+bidRowCountNew+'][quantity_purchased]"></input></tr>')
		else 
			$('#bidsTable tbody').append('<tr id="'+bidRowId+'"><td><a id="'+remove_bid_row_id+'"> - </a><td><input id="'+bidNumberByRow+'" name="auction['+bidRowCountNew+'][bid_number]"></input><td><input id="'+bidAmountByRow+'" name="auction['+bidRowCountNew+'][bid_amount]"></input><td><input id="'+quantityPurchasedByRow+'" disabled name="auction['+bidRowCountNew+'][quantity_purchased]"></input></tr>')
		end


