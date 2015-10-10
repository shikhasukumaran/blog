require 'digest/sha2' 

class UserMailer < ActionMailer::Base
  default from: "Mailgun Sandbox <postmaster@sandbox1f3e6d7e4fd842f3b45f2146a4498f34.mailgun.org"
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"

  helper ApplicationHelper

  def send_invoice_email(invoice)
  	@invoice = invoice
  	@bid_number = BidNumber.find(@invoice.bid_number_id)

  	@guests = Guest.where(bid_number: @bid_number.bid_number)

  	@guests.each do |guest|
  		@guest = guest
  		if !@guest.email.blank?
  			mail(to: @guest.email, subject: 'SHARE : 13th Annual Harvest Dinner And Silent Auction')
  		end
  	end
  end
end
