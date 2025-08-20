require 'rack'
require_relative 'lib/formatter'

class App
  def call(env)
    request = Rack::Request.new(env)
    request_params = request.params['format'] || ''

    handle_time_request(TimeFormatter.new(request_params))   
  end

  
  private

  def handle_time_request(time_formatter_class)

    formatter = time_formatter_class
    result = formatter.format_time

    if formatter.valid?
      success_response(result)
    else
      error_response(result)
    end
  end

  def success_response(body)
    [200, {}, [body]]
  end

  def error_response(unknown_format)
    error_message = "Unknown time format [#{unknown_format.join(', ')}]"
    [400, {}, [error_message]]
  end
end
