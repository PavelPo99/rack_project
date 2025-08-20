require 'rack'
require_relative 'app'

use Rack::ContentType

app = Rack::URLMap.new "/time" => App.new
run app
