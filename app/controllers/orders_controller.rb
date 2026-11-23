class OrdersController < ApplicationController
  before_action :load_order, only: %i[show advance document]

  DOCUMENT_STAGES = {
    "delivery-note" => %w[packed dispatched invoiced],
    "invoice" => %w[invoiced]
  }.freeze

  def index
    @orders = Order.order(created_at: :desc, id: :desc)
  end

  def new
    @order = Order.new(quantity: 1, channel: "retail")
  end

  def create
    @order = Order.new(params.expect(order: %i[customer email channel product_code quantity]))
    if @order.save
      redirect_to @order, notice: "Order received.", status: :see_other
    else
      render :new, status: 422
    end
  end

  def show
  end

  def advance
    if @order.advance_from(params[:expected_status])
      redirect_to @order, notice: "Order status updated.", status: :see_other
    else
      flash.now[:alert] = "The order cannot move from that stage. Review its current status."
      @order.reload
      render :show, status: :conflict
    end
  end

  def document
    @kind = params[:kind]
    stages = DOCUMENT_STAGES.fetch(@kind, [])
    return head :not_found unless stages.include?(@order.status)

    response.headers["Cache-Control"] = "no-store"
    render :document
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end
end
