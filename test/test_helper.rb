ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  def order_attributes(**overrides)
    {
      customer: "Demo Optics", email: "qa@example.test", channel: "trade",
      product_code: "SV-DEMO", quantity: 2
    }.merge(overrides)
  end
end
