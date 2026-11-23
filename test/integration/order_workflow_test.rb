require "test_helper"

class OrderWorkflowTest < ActionDispatch::IntegrationTest
  test "create uses catalogue price and starts at received" do
    assert_difference "Order.count", 1 do
      post orders_path, params: { order: order_attributes(
        channel: "retail", unit_price_cents: 1, product_name: "Override", status: "invoiced"
      ) }
    end
    order = Order.last
    assert_response :see_other
    assert_redirected_to order_path(order)
    assert_equal ["retail", "received", 2450, "Single-vision lens sample"],
      [order.channel, order.status, order.unit_price_cents, order.product_name]
    follow_redirect!
    assert_select "dd", text: "€49.00"
  end

  test "invalid request renders errors without creating an order" do
    assert_no_difference "Order.count" do
      post orders_path, params: { order: order_attributes(quantity: "101") }
    end
    assert_response 422
    assert_select "[role=alert]", text: /Quantity/
    assert_select "input#order_customer[value='Demo Optics']", count: 1
  end

  test "stage changes and document availability follow the workflow" do
    order = Order.create!(order_attributes)
    get document_order_path(order, kind: "delivery-note")
    assert_response :not_found

    %w[received packed dispatched].zip(%w[packed dispatched invoiced]).each do |from, to|
      get document_order_path(order, kind: "invoice")
      assert_response :not_found
      patch advance_order_path(order), params: { expected_status: from }
      assert_response :see_other
      assert_equal to, order.reload.status
      get document_order_path(order, kind: "delivery-note")
      assert_response :success
      assert_select "h1", "Delivery note"
      assert_select "dt", text: /price|total/i, count: 0
    end

    get document_order_path(order, kind: "invoice")
    assert_response :success
    assert_select "h1", "Sample invoice"
    assert_select "dd", text: "€49.00"

    patch advance_order_path(order), params: { expected_status: "invoiced" }
    assert_response :conflict
    assert_equal "invoiced", order.reload.status
  end

  test "a repeated stage action cannot perform the next stage" do
    order = Order.create!(order_attributes)
    2.times { patch advance_order_path(order), params: { expected_status: "received" } }
    assert_response :conflict
    assert_select "[role=alert]", text: /current status/
    assert_equal "packed", order.reload.status
  end

  test "unknown requests return useful status codes" do
    order = Order.create!(order_attributes)
    get order_path(0)
    assert_response :not_found
    get document_order_path(order, kind: "unknown")
    assert_response :not_found
    post orders_path, params: { other: "payload" }
    assert_response :bad_request
  end
end
