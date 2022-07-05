require_relative 'time_body'
require_relative 'time_app'

use Rack::Reloader
use TimeBody

run TimeApp.new
