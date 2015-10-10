# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_invoice_email_preview
  	@guest = Guest.where(first_name: "Shikha").first
  	@bid_number = BidNumber.where(bid_number: @guest.bid_number).first
  	@invoice = @bid_number.invoices.last
  	puts @guest.inspect
    UserMailer.send_invoice_email(@invoice)
  end
end
