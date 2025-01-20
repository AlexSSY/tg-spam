class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Performing a background job with args: #{args.inspect}"
  end
end
