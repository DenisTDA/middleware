class TimeApp
  PATH = '/time'.freeze

  def call(env)
    request = Rack::Request.new env
    result = ParamsParser.new(request)

    if request_valid?(request)
      if result.valid?
        status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
        body = result.body_good_params
      else
        status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
        body = result.body_bad_params
      end

    else
      status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found]
      body = ["Invalid path\n"]
    end

    Rack::Response.new(body, status, {}).finish
  end

  private

  def request_valid?(request)
    request.path.eql?(PATH)
  end
end
