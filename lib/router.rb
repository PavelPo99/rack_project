require_relative 'time_formatter'

class Router
  def initialize(request)
    @request = request
  end

  def route
    case
    when @request.get? && @request.path == '/time'
      handle_time_request
    else
      not_found_response
    end
  end

  private

  def handle_time_request
    formatter = TimeFormatter.new(@request)
    result = formatter.response

    if formatter.error.empty?
      success_response(result)
    else
      error_response(result)
    end
  end

  def success_response(body)
    [200, {'Content-Type' => 'text/plain'}, [body]]
  end

  def error_response(errors)
    error_message = "Unknown time format [#{errors.join(', ')}]"
    [400, {'Content-Type' => 'text/plain'}, [error_message]]
  end

  def not_found_response
    [404, {'Content-Type' => 'text/plain'}, ["Not found"]]
  end
end
