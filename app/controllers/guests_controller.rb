class GuestsController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
	  @guests = Guest.where(event_id: params[:event_id]).order(:guest_of)
  end

  def new
    @event = Event.find(params[:event_id])
	  @guest = @event.guests.build
  end

  def edit
    @guest = Guest.find(params[:id])
    @event = Event.find(@guest.event_id)
  end


  def create
    @event = Event.find(params[:event_id])
    @guest = @event.guests.create(guest_params)

    # Create bid number in system if not already present
  	bid_number = @guest.bid_number

    save_bid_num_result = true
    save_guest_result = true
    
    Guest.transaction do
      if !bid_number.blank?
        @bid_number_ob = BidNumber.where(bid_number: bid_number).first
        if !@bid_number_ob
          @bid_number_ob = @event.bid_numbers.create(:bid_number => bid_number, :event_due_amount => 0, :event_due_pay_status => "NOT_PAID", :invoice_email_status => "NOT_SENT")
          save_bid_num_result = @bid_number_ob.save
        end
      end
      save_guest_result = @guest.save
    end # end of transaction
    
    if save_bid_num_result && save_guest_result
      redirect_to  guest_path(@guest), notice: "Guest saved"
    else
      render 'edit'
    end
  end

  def update
    @guest = Guest.find(params[:id])
    @event = Event.find(@guest.event_id)
    
    # Create bid number in system if not already present
    bid_number = params[:guest][:bid_number]
    save_bid_num_result = true
    update_guest_result = true

    Guest.transaction do
      if !bid_number.blank?
        @bid_number_ob = BidNumber.where(bid_number: bid_number).first
        if !@bid_number_ob
          @bid_number_ob = @event.bid_numbers.create(:bid_number => bid_number, :event_due_amount => 0, :event_due_pay_status => "NOT_PAID", :invoice_email_status => "NOT_SENT")
          save_bid_num_result = @bid_number_ob.save
        end
      end
      update_guest_result = @guest.update(guest_params)
    end # end of transaction

    if save_bid_num_result && update_guest_result
      redirect_to  guest_path(@guest), notice: "Guest updated"
    else
      render 'edit'
    end
  end

  def show
    @guest = Guest.find(params[:id])
    @event = Event.find(@guest.event_id)
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to guests_path(@event), notice: "Guest is successfully deleted!"
  end

 private
  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :middle_name, :guest_of,:billing_address_1, :billing_address_2, :city, :state, :zip_code,:email, :phone_number, :bid_number, :table_number, :dinner_tickets, :registration_status, :registration_fee, :registration_fee_mode, :event_status, :fee_adjustment)
  end
end
