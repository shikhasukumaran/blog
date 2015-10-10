class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :bid_number
      t.string :auction_type # created to filter by type in invoice.
      t.decimal :bid_amount, :precision => 10, :scale => 2
      t.integer :quantity_purchased  # for fixed price items - bid amount = quantity_purchased * fair_market_value
      t.boolean :is_winner

      t.references :auction, index: true
      t.timestamps
    end
  end
end
