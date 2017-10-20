class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :status
      t.integer :client_id

      t.timestamps
    end
  end
end
