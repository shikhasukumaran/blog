class CreateBidNumbers < ActiveRecord::Migration
  def change
    create_table :bid_numbers do |t|
      t.integer :bid_number
      t.decimal :event_due_amount, :precision => 10, :scale => 2
      t.string :event_due_pay_status
      t.string :invoice_email_status
      t.decimal :fee_adjustment, :precision => 10, :scale => 2

      t.references :event, index: true
      t.timestamps
    end
  end
end
