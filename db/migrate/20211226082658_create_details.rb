class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :tax_included_price
      t.integer :amount
      t.integer :making_status, default: 0, null: false, limit: 1


      t.timestamps
    end
  end
end
