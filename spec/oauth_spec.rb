require File.dirname(__FILE__) + '/spec_helper'

describe "Warden::Github" do
  it "requesting an url that requires authentication redirects to bootic" do
    response = get "/"

    uri = Addressable::URI.parse(response.headers["Location"])

    uri.scheme.should eql('https')
    uri.host.should eql('api.bootic.net')

    params = uri.query_values
    params['response_type'].should eql('code')
    params['scope'].should eql('public')
    params['client_id'].should match(/\w{20}/)
    params['redirect_uri'].should eql('http://example.org/auth/bootic/callback')
  end
end
