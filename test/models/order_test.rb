require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "catalogue name and price are snapshotted and total is calculated in cents" do
    order = Order.create!(order_attributes(product_code: "CL-DEMO", quantity: 3))
    assert_equal "Contact lens trial pack", order.product_name
    assert_equal 1290, order.unit_price_cents
    assert_equal 3870, order.total_cents
    assert_equal "received", order.reload.status
  end

  test "quantity accepts both endpoints and rejects invalid quantities" do
    [1, 100].each do |quantity|
      assert Order.new(order_attributes(quantity: quantity)).valid?, quantity.to_s
    end

    [nil, 0, 101, "1.5", "2abc"].each do |quantity|
      order = Order.new(order_attributes(quantity: quantity))
      assert_not order.valid?, quantity.inspect
      assert order.errors[:quantity].any?, quantity.inspect
    end
  end

  test "trimmed customer and email pass validation" do
    order = Order.create!(order_attributes(customer: " Demo Optics ", email: " qa@example.test "))
    assert_equal "Demo Optics", order.customer
    assert_equal "qa@example.test", order.email
  end

  test "invalid customer and catalogue data are rejected" do
    order = Order.new(order_attributes(customer: " ", email: "invalid", channel: "unknown", product_code: "missing"))
    assert_not order.valid?
    assert_equal %i[channel customer email product_code], order.errors.attribute_names.sort
    assert_not Order.new(order_attributes(customer: "X" * 101)).valid?
  end

  test "status update checks the expected stage at the database" do
    order = Order.create!(order_attributes)
    duplicate = Order.find(order.id)
    assert_not order.advance_from("dispatched")
    assert order.advance_from("received")
    assert_not duplicate.advance_from("received")
    assert_equal "packed", order.reload.status
  end
end
