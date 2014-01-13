# encoding: UTF-8

module Resque
  class Payment
    @queue = self.name

    def self.perform item_id
      sleep 2.5
    end

  end
end
