require 'warden'
require 'oauth2'
require 'json'

module Warden
  module Bootic
    API_URL = ENV['BOOTIC_API_URL'] || 'https://api.bootic.net'
  end
end

require 'warden-bootic/user'
require 'warden-bootic/proxy'
require 'warden-bootic/version'
require 'warden-bootic/strategy'
