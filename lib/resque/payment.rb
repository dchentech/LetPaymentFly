# encoding: UTF-8

module Resque
  class Payment
    @queue = self.name

    def self.perform payment_id
      sleep 3
      puts "process Payment[#{payment_id}]"

      @order = Order.find_or_create_by_payment_id(payment_id)
      @order.status = !(rand(3) % 3).zero? # only two-thirds opportunity of success
      @order.save
    end

  end
end
