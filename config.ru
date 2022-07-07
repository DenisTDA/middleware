require_relative 'time_builder'
require_relative 'time_app'
ROUTES = {
  '/time' => TimeApp.new
}

use Rack::ContentType, 'text/plain'
use Rack::Reloader

run Rack::URLMap.new(ROUTES)
