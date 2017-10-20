class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :description
      t.decimal :unit_cost
      t.integer :quantity
      t.decimal :balance
      t.decimal :discount
      t.decimal :tax
      t.integer :invoice_id

      t.timestamps
    end
  end
end
