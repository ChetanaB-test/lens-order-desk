class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :customer, null: false
      t.string :email, null: false
      t.string :channel, null: false
      t.string :product_code, null: false
      t.string :product_name, null: false
      t.integer :quantity, null: false
      t.integer :unit_price_cents, null: false
      t.string :status, null: false, default: "received"
      t.timestamps
    end

    add_check_constraint :orders, "quantity BETWEEN 1 AND 100", name: "order_quantity"
    add_check_constraint :orders, "unit_price_cents > 0", name: "order_price"
    add_check_constraint :orders, "channel IN ('retail', 'trade')", name: "order_channel"
    add_check_constraint :orders, "status IN ('received', 'packed', 'dispatched', 'invoiced')", name: "order_status"
  end
end
