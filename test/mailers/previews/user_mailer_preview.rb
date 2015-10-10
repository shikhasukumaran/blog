# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_invoice_email_preview
  	@guest = Guest.where(first_name: "Shikha").first
  	puts @guest.inspect
    UserMailer.send_invoice_email(@guest)
  end
end
