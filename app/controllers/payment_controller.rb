# encoding: UTF-8

class PaymentController < ApplicationController
  before_filter do
  end

  def show
    if not params[:id]
      redirect_to payment_path(test_item_id)
      return
    end

    Resque.enqueue Resque::Payment, test_item_id
  end

  def buy
  end

  def test_item_id
    @test_item_id ||= (params[:id] = rand(10**10))
  end

end
