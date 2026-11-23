if Rails.env.development?
  Order.find_or_create_by!(email: "demo-order@example.test") do |order|
    order.customer = "North Quay Optics"
    order.channel = "trade"
    order.product_code = "SV-DEMO"
    order.quantity = 2
  end
end
