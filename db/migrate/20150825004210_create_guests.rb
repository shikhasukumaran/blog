class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :guest_of
      t.string :billing_address_1
      t.string :billing_address_2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :email
      t.string :phone_number
      t.integer :bid_number
      t.string  :table_number
      t.integer :dinner_tickets
      t.string  :registration_status     # (PAID|UNPAID)
      t.decimal :registration_fee, :precision => 10, :scale => 2
      t.string  :registration_fee_mode #(CASH|CREDIT_CARD|CHEQUE)
      t.string :event_status  #(REGISTERED|ARRIVED|CHECKED_OUT) checked out means paid.
      
      t.references :event, index: true
      t.timestamps
    end
  end
end
