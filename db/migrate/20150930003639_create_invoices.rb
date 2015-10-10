class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :version
      t.datetime :creation_date
      t.string :status  # PAID, PAID_EMAILED

      t.references :bid_number, index: true
      t.timestamps
    end
  end
end
