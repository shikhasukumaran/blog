class GuestsController < ApplicationController

  def index
	@guests = Guest.all
  end

  def new
	 @guest = Guest.new
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def create
	@guest = Guest.new(guest_params)
	
  	if @guest.save
  		redirect_to @guest
  	else
  		render 'new'
  	end
  end

  def update
    @guest = Guest.find(params[:id])
 
    if @guest.update(guest_params)
      redirect_to @guest
    else
      render 'edit'
    end
  end

  def show
    @guest = Guest.find(params[:id])
  end

 private
  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :middle_name, :billing_address_1, :billing_address_2, :email, :phone_number, :bid_number, :table_number, :dinner_tickets, :registration, :status)
  end
end
