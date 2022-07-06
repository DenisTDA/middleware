class TimeApp
  
  def call(env)
    request = Rack::Request.new env
    result = ParamsParser.new(request)

    if result.valid?
      status, body = result.create_result
    else
      status, body = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found], ["Invalid path\n"]
    end
    Rack::Response.new(body, status, {}).finish
  end
end
