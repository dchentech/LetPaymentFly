Dir[Rails.root.join("lib/resque/*")].map do |file|
  require file
end

module Resque
end
