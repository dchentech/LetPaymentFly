class Order < ActiveRecord::Base
  def success?; self.status?; end
end
