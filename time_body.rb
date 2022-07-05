class TimeBody
  
  BAD_REQUEST = 400
  GOOD_REQUEST = 200
  TIME_CALL = { 'year' => :year, 'month' => :month, 'day' => :day,
                'hour' => :hour, 'minute' => :min, 'second' => :sec }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    body = body_bad_request(body) if status == BAD_REQUEST
    body = body_good_request(body) if status == GOOD_REQUEST

    [status, headers, body]
  end

  private

  def body_bad_request(body)
    str = body.map { |param| "[#{param}]" }.join(',')
    ["Unknown time format: #{str}\n"]
  end

  def body_good_request(body)
    time = Time.now
    str = body.map { |param| time.send(TIME_CALL[param]).to_s }.join('-')
    ["#{str}\n"]
  end
end
