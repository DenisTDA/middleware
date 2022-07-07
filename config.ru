require_relative 'time_builder'
require_relative 'time_app'

use Rack::ContentType, 'text/plain'
use Rack::Reloader

ROUTES = {
  '/time' => TimeApp.new
}

run Rack::URLMap.new(ROUTES)
