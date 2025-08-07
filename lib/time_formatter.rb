
class TimeFormatter
  VALID_FORMATS = {
    'year' => '%Y', 
    'month' => '%m', 
    'day' => '%d',
    'hour' => '%H', 
    'minute' => '%M', 
    'second' => '%S'
  }.freeze

  def initialize(request)
    @request = request
    @errors = []
    @formatted_time = format_time
  end

  def response
    if @errors.empty?
      [200, {'Content-Type' => 'text/plain'}, [@formatted_time]]
    else
      [400, {'Content-Type' => 'text/plain'}, ["Unknown time format [#{@errors.join(', ')}]"]]
    end
  end

  private

  def format_time
    format_param = @request.params['format'] || ''
    return "" if format_param.empty?

    time = Time.now
    components = []

    format_param.split(',').each do |format|
      format = format.strip
      if VALID_FORMATS.key?(format)
        components << time.strftime(VALID_FORMATS[format])
      else
        @errors << format
      end
    end

    components.join('-')
  end
end
