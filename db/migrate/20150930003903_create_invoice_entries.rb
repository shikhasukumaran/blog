class CreateInvoiceEntries < ActiveRecord::Migration
  def change
    create_table :invoice_entries do |t|
      t.integer :auction_id
      t.string  :auction_type
      t.integer :bid_id
      t.decimal :bid_amount, :precision => 10, :scale => 2
      t.integer :quantity_purchased
      t.references :invoice, index: true
      t.timestamps
    end
  end
end
