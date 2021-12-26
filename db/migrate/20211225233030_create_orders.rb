class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :address
      t.string :name
      t.string :postal_code
      t.integer :postage
      t.integer :total_payment
      t.integer :payment_method
      t.integer :status, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
