class TimeFormatter
  VALID_FORMATS = {
    'year' => '%Y', 
    'month' => '%m', 
    'day' => '%d',
    'hour' => '%H', 
    'minute' => '%M', 
    'second' => '%S'
  }.freeze

  def initialize(request_params)
    @formatted_time = request_params
    @unknown_format = []
  end

  def format_time
    time = Time.now
    components = []

    @formatted_time.split(',').each do |format|
      format = format.strip
      if VALID_FORMATS.key?(format)
        components << time.strftime(VALID_FORMATS[format])
      else
        @unknown_format << format
      end
    end

    valid? ? components.join('-') : @unknown_format 
  end

  def valid?
    @unknown_format.empty?
  end
end
