require "uri"

class Order < ApplicationRecord
  CATALOG = {
    "SV-DEMO" => { name: "Single-vision lens sample", cents: 2450 }.freeze,
    "CL-DEMO" => { name: "Contact lens trial pack", cents: 1290 }.freeze
  }.freeze
  CHANNELS = { "Retail (B2C)" => "retail", "Trade (B2B)" => "trade" }.freeze
  NEXT_STATUS = {
    "received" => "packed",
    "packed" => "dispatched",
    "dispatched" => "invoiced"
  }.freeze

  normalizes :customer, with: ->(value) { value.strip }
  normalizes :email, with: ->(value) { value.strip }
  
# Save the catalogue name and price at creation so later catalogue changes don't affect existing orders.

  before_validation :snapshot_product, on: :create
  validates :customer, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 254 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :channel, inclusion: { in: CHANNELS.values }
  validates :product_code, inclusion: { in: CATALOG.keys }, on: :create
  validates :quantity, numericality: { only_integer: true, in: 1..100 }

  def total_cents
    quantity * unit_price_cents
  end

  def advance_from(expected_status)
    next_status = NEXT_STATUS[expected_status]
    return false unless next_status

    # Compare and update in one statement so a stale click cannot skip a stage.
    self.class.where(id: id, status: expected_status)
      .update_all(status: next_status, updated_at: Time.current) == 1
  end

  private

  def snapshot_product
    product = CATALOG[product_code]
    return unless product

    self.product_name = product.fetch(:name)
    self.unit_price_cents = product.fetch(:cents)
  end
end
