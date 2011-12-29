ENV['RACK_ENV'] ||= 'development'

begin
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:runtime, :test)
require "ruby-debug"

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'warden-bootic'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec', 'app'))

class Fix
  
  def initialize(app)
    @app = app
  end
  
  def call(env)
    status, headers, response = @app.call(env)
    headers['Content-Type'] = 'text/html'
    [status, headers, response]
  end
end

use Fix
run Example.app

# vim:ft=ruby
