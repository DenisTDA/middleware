class TimeApp
  def call(env)
    request = Rack::Request.new env
    result = TimeBuilder.new(request)

    if result.valid?
      status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
      body = result.time
    else
      status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      body = result.errors
    end

    Rack::Response.new(body, status, {}).finish
  end
end
