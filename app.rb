require 'rack'
require_relative 'lib/time_formatter'


class App
  def call(env)
    request = Rack::Request.new(env)
    
    if request.get? && request.path == '/time'
      TimeFormatter.new(request).response
    else
      not_found_response
    end
  end

  private

  def not_found_response
    [404, {'Content-Type' => 'text/plain'}, ["Not found"]]
  end
end
