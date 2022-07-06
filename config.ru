require_relative 'params_parser'
require_relative 'time_app'

use Rack::ContentType, "text/plain"
use Rack::Reloader

run TimeApp.new
