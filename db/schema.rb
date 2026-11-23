# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_01_000000) do
  create_table "orders", force: :cascade do |t|
    t.string "customer", null: false
    t.string "email", null: false
    t.string "channel", null: false
    t.string "product_code", null: false
    t.string "product_name", null: false
    t.integer "quantity", null: false
    t.integer "unit_price_cents", null: false
    t.string "status", default: "received", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "channel IN ('retail', 'trade')", name: "order_channel"
    t.check_constraint "quantity BETWEEN 1 AND 100", name: "order_quantity"
    t.check_constraint "status IN ('received', 'packed', 'dispatched', 'invoiced')", name: "order_status"
    t.check_constraint "unit_price_cents > 0", name: "order_price"
  end
end
