require 'CSV'

class EventsController < ApplicationController
  
  def index
  	@events = Event.all
  end

  def new
	 @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def upload_auctions
    @event = Event.find(params[:id])

    filename = "/Users/shikhasu/Documents/roughWork/Auctions_test.csv"

    auction_rows = []
    CSV.foreach(filename, encoding:'iso-8859-1:utf-8',headers:true) do |row|
      auction_row = {}
      number = row['Number']
      name = row['Name']
      auction_row[:value] = row['Value']
      auction_row[:auction_name] = number + "_" + name

      puts auction_row[:auction_name] + ", " + auction_row[:value]
      if !auction_row[:auction_name].blank? && float_or_nil(auction_row[:value])
        auction_rows << auction_row
        puts auction_row.inspect
      end
    end

    Event.transaction do
      auction_rows.each do |auction_row|
        auction_new = @event.auctions.build(:name => auction_row[:auction_name], :description => auction_row[:auction_name], :status => :OPEN, :fair_market_value => auction_row[:value], :auction_type => :SILENT_AUCTION)
        auction_new.save
      end
    end

    redirect_to event_auctions_path(@event), notice: "Auctions uploaded for the event"
  end

  def upload_guests
    @event = Event.find(params[:id])
    filename = "/Users/shikhasu/Documents/roughWork/guest_test_upload.csv"

    guest_rows = []
    CSV.foreach(filename, encoding:'iso-8859-1:utf-8',headers:true) do |row|
      # Fields from excel
      guest_row = {}
      if !row['FIRST_NAME'].blank?
        puts "name " + row.inspect
      end
      guest_row[:first_name] = row['FIRST_NAME']
      guest_row[:last_name] = row['LAST_NAME']
      guest_row[:email] = row['EMAIL']
      guest_row[:guest_of] = row['GUEST_OF']
      guest_row[:dinner_tickets] = Integer_or_nil(row['DINNER_TICKETS'])
      guest_row[:registration_status] = row['PAY_STATUS']
      guest_row[:registration_fee] = float_or_nil(row['REGISTRATION_FEE'])
      guest_row[:registration_fee_mode] = row['PAYMENT_TYPE']
      guest_row[:billing_address_1] = row['ADDRESS']
      guest_row[:city] = row['CITY']
      guest_row[:zip_code] = Integer_or_nil(row['ZIP_CODE'])
      guest_row[:phone_number] = row['PHONE_NUMBER']
      guest_row[:table_number] = Integer_or_nil(row['TABLE_NUMBER'])

      if !guest_row[:first_name].blank? && !guest_row[:last_name].blank?  && !guest_row[:registration_status].blank?
        guest_rows << guest_row
        puts guest_row.inspect
      end
    end

    Guest.transaction do 
      guest_rows.each do |guest_row|
        guest_new = @event.guests.build(:first_name => guest_row[:first_name],  
                                         :last_name => guest_row[:last_name],
                                         :registration_status => guest_row[:registration_status],                                  
                                        :email => guest_row[:email], 
                                        :guest_of => guest_row[:guest_of],
                                        :dinner_tickets => guest_row[:dinner_tickets],
                                        :registration_fee => guest_row[:registration_fee],
                                        :registration_fee_mode => guest_row[:registration_fee_mode],
                                        :billing_address_1 => guest_row[:billing_address_1],
                                        :city => guest_row[:city],
                                        :zip_code => guest_row[:zip_code],
                                        :phone_number => guest_row[:phone_number],
                                        :table_number => guest_row[:table_number])
        save_result = guest_new.save
        puts guest_new.errors.inspect
      end
    end
    redirect_to event_guests_path(@event), notice: "Guests uploaded for the event"

  end

  def create
	@event = Event.new(event_params)
	
  	if @event.save
  		redirect_to @event
  	else
  		render 'new'
  	end
  end

  def update
    @event = Event.find(params[:id])
 
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "Event is successfully deleted!"
  end

private
  def event_params
    params.require(:event).permit(:title, :description, :created_by)
  end
  
  def float_or_nil(string)
    if string.blank? 
      return nil 
    end
    Float(string.strip || '')
    rescue ArgumentError
    nil
  end
  def Integer_or_nil(string)
    if string.blank? 
      return nil 
    end
    Integer(string.strip || '')
    rescue ArgumentError
    nil
  end

end
