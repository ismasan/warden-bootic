require 'rest-client'

module Example
  class App < Sinatra::Base
    
    use Rack::Session::Cookie, :key => 'rack.session',
                               :path => '/',
                               :expire_after => 2592000, # In seconds
                               :secret => 'change_me',
                               :old_secret => 'change_me'
    enable  :raise_errors
    disable :show_exceptions

    use Warden::Manager do |manager|
      manager.default_strategies :bootic
      manager.failure_app = BadAuthentication

      manager[:client_id]    = ENV['OAUTH_CLIENT_ID'] || '12345678901234567890' # or test id
      manager[:secret]       = ENV['OAUTH_CLIENT_SECRET']

      manager[:scopes]       = 'public'
      manager[:callback_url] = '/auth/bootic/callback'
    end
    
    helpers do
      def ensure_authenticated
        unless env['warden'].authenticate!
          throw(:warden)
        end
      end

      def user
        env['warden'].user
      end
      
      def bootic(path)
        JSON.parse(RestClient.get("#{Warden::Bootic::API_URL}/#{path}", :params => { :access_token => user.token }, :accept => :json))
      end
    end

    get '/' do
      ensure_authenticated
      p [:user, user.attribs]
      "Hello There, #{user.user_name}!. Your token: #{user.token.inspect}"
    end
    
    get '/products' do
      ensure_authenticated
      bootic('/products')['entries'].map do |product|
        html = '<div>'
        html += "<h2>#{product['title']}</h2>"
        html += %(<img src="#{product['images'].first['small']}" />) if product['images'].any?
        html += '/<div>'
        html
      end.join("\n")
    end

    get '/redirect_to' do
      ensure_authenticated
      "Hello There, #{user.user_name}! return_to is working!"
    end

    get '/auth/bootic/callback' do
      ensure_authenticated
      redirect '/'
    end

    get '/logout' do
      env['warden'].logout
      "Peace!"
    end
  end

  class BadAuthentication < Sinatra::Base
    get '/unauthenticated' do
      status 403
      "Unable to authenticate, sorry bud."
    end
  end

  def self.app
    @app ||= Rack::Builder.new do
      run App
    end
  end
end
