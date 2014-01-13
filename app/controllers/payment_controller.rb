# encoding: UTF-8

class PaymentController < ApplicationController

  def show
    if not params[:id]
      redirect_to payment_path(test_item_id)
      return
    end

    Resque.enqueue Resque::Payment, test_item_id
  end

  def buy
  end

  def check
    @order = Order.find_by_payment_id(params[:id])
    status = if @order
      @order.success? ? 'success' : 'failure'
    else
      'waiting'
    end

    render :json => {:status => status}
  end

  private
  def test_item_id
    @test_item_id ||= (params[:id] = rand(10**10))
  end

end
