class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :bid_number
      t.decimal :bid_amount, :precision => 10, :scale => 2
      t.boolean :is_winner

      t.references :auction, index: true

      t.timestamps
    end
  end
end
