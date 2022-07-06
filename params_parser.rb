class ParamsParser
  
  TIME_CONST = { 'year' => :year, 'month' => :month, 'day' => :day,
                'hour' => :hour, 'minute' => :min, 'second' => :sec }.freeze
  PATH = '/time'.freeze                

  def initialize(request)
    @path = request.path
    @params = request.params['format']
  end

  def create_result
    if correct?
      [ Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok], body_good_params ]
    else
      [ Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request], body_bad_params ]
    end
  end

  def correct?
    params_incorrect.empty?
  end

  def valid?
    @path.eql?(PATH) && !@params.nil?
  end

  private

  def body_bad_params
    str = params_incorrect.map { |param| "[#{param}]" }.join(',')
    ["Unknown time format: #{str}\n"]
  end

  def body_good_params
    time = Time.now
    str = params_parser.map { |param| time.send(TIME_CONST[param]).to_s }.join('-')
    ["#{str}\n"]
  end

  def params_parser
    @params.split(',')
  end

  def params_incorrect
    params_parser.select { |param| !TIME_CONST.include?(param) }
  end
end
