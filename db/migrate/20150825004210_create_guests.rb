class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :billing_address_1
      t.string :billing_address_2
      t.string :email
      t.integer :phone_number
      t.integer :bid_number
      t.string  :table_number
      t.integer :dinner_tickets
      t.decimal :registration, :precision => 10, :scale => 2
      t.string  :status
      
      t.timestamps
    end
  end
end
