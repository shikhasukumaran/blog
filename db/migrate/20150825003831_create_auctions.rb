class CreateAuctions < ActiveRecord::Migration
  def up
    create_table :auctions do |t|
      t.string :name, :limit => 80, :null => false
      t.text :description
      t.string :auction_type
      t.string :donor_name
      t.boolean :can_multiple_bid_win
      t.decimal :fair_market_value, :precision => 10, :scale => 2
      t.integer :winning_bid_number
      t.integer :quantity
      t.references :event, index: true
      t.string :status
      t.timestamps
    end
    execute "CREATE UNIQUE INDEX unique_name_index ON auctions(name);"
  end
end
