Warden::Strategies.add(:bootic) do
  # Need to make sure that we have a pure representation of the query string.
  # Rails adds an "action" parameter which causes the openid gem to error
  def params
    @params ||= Rack::Utils.parse_query(request.query_string)
  end

  def authenticate!
    if params['code']
      begin
        access_token = access_token_for(params['code'])
        user = JSON.parse(access_token.get('/oauth/me'))
        success!(Warden::Bootic::Oauth::User.new(user, access_token.token))
      rescue OAuth2::HTTPError
        %(<p>Outdated ?code=#{params['code']}:</p><p>#{$!}</p><p><a href="/auth/bootic">Retry</a></p>)
      end
    else
      env['rack.session']['return_to'] = env['REQUEST_URI']
      throw(:warden, [ 302, {'Location' => authorize_url}, [ ]])
    end
  end

  private

  def oauth_client
    oauth_proxy.client
  end

  def authorize_url
    oauth_proxy.authorize_url
  end

  def access_token_for(code)
    oauth_proxy.access_token_for(code)
  end

  def oauth_proxy
    @oauth_proxy ||= Warden::Bootic::Oauth::Proxy.new(env['warden'].config[:client_id],
                                                      env['warden'].config[:secret],
                                                      env['warden'].config[:scopes],
                                                      callback_url)
  end

  def callback_url
    absolute_url(request, env['warden'].config[:callback_url])
  end

  def absolute_url(request, suffix = nil)
    port_part = case request.scheme
                when "http"
                  request.port == 80 ? "" : ":#{request.port}"
                when "https"
                  request.port == 443 ? "" : ":#{request.port}"
                end
    "#{request.scheme}://#{request.host}#{port_part}#{suffix}"
  end
end
