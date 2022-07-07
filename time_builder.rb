class TimeBuilder
  TIME_CONST = { 'year' => :year, 'month' => :month, 'day' => :day,
                 'hour' => :hour, 'minute' => :min, 'second' => :sec }.freeze

  def initialize(request)
    @path = request.path
    @params = request.params['format']
  end

  def correct?
    params_incorrect.empty?
  end

  def valid?
    params_exist? && params_correct?
  end

  def errors
    return unless params_exist?

    str = params_incorrect.map { |param| "[#{param}]" }.join(',')
    "Unknown time format: #{str}\n"
  end

  def time
    time = Time.now
    str = params_parser.map { |param| time.send(TIME_CONST[param]).to_s }.join('-')
    "#{str}\n"
  end

  private

  def params_parser
    @params.split(',')
  end

  def params_incorrect
    params_parser.reject { |param| TIME_CONST.keys.include?(param) }
  end

  def params_exist?
    !@params.nil? && !@params.empty?
  end

  def params_correct?
    params_incorrect.empty?
  end
end
