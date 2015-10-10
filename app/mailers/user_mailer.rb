require 'digest/sha2' 
#require 'rest_client'

class UserMailer < ActionMailer::Base
  default from: "shelterboard13@gmail.com"
 # default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@mailgun.org"

  helper ApplicationHelper

  def send_invoice_email(invoice)
  	@invoice = invoice
  	@bid_number = BidNumber.find(@invoice.bid_number_id)

  	@guests = Guest.where(bid_number: @bid_number.bid_number)

    @recipients = []
    @recipients << "shelterboard13@gmail.com"
  	@guests.each do |guest|
  		@guest = guest
  		if !@guest.email.blank?
        @recipients << @guest.email
        emails = @recipients.map(&:inspect).join(',')
  			mail(to: emails, subject: 'SHARE : 13th Annual Harvest Dinner And Silent Auction')
  		end
  	end
  end


  def send_test_email
 #     RestClient.post "https://api:key-ffbd167914d61e782f37d774bcda046a"\
 # "@api.mailgun.net/v3/mg.share.com/messages",
 # :from => "shikha.sukumaran@gmail.com",
 # :to => "shikha.sukumaran@gmail.com",
 # :subject => "Hello",
 # :text => "Testing some Mailgun awesomness!"

  end
end
