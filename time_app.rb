class TimeApp
  
  TIME_CONST = %w[year month day hour minute second].freeze
  BAD_REQUEST = 400
  NO_RESOURCE = 403
  GOOD_REQUEST = 200
  PATH = '/time'.freeze

  def call(env)
    request = Rack::Request.new env
    status = check_status(request)
    body = create_body(request)

    [status, { 'Content-Type' => 'text/plain' }, body]
  end

  private

  def check_status(request)
    if !request.path.eql?(PATH)
      NO_RESOURCE
    elsif !incorrect(request).empty?
      BAD_REQUEST
    else
      GOOD_REQUEST
    end
  end

  def t_body(request)
    request.params['format'] ? request.params['format'].split(',') : []
  end

  def incorrect(request)
    t_body(request).select { |param| !TIME_CONST.include?(param) }
  end

  def create_body(request)
    incorrect(request).empty? ? t_body(request) : incorrect(request)
  end
end
