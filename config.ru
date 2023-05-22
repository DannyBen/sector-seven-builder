require 'adsf'
require 'byebug'

class OptionalHTML
  def initialize(app)
    @app = app
  end

  def call(env)
    orig_path = env['PATH_INFO']
    resp = @app.call(env.merge!({ 'PATH_INFO' => "#{orig_path}.html" }))
    found = resp[0] == 404 ? false : resp
    found or @app.call(env.merge!('PATH_INFO' => orig_path))
  end
end

use OptionalHTML
use Adsf::Rack::IndexFileFinder, root: 'site'
run Rack::File.new 'site'
