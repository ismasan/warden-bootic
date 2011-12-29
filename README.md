warden-bootic
=============

NOTE: this code is basically warden-github adapted to work against Bootic oauth provider.

https://github.com/atmos/warden-github

A [warden](http://github.com/hassox/warden) strategy that provides oauth authentication to Bootic.  IN PROGRESS.

To test it out on localhost set your callback url to 'http://localhost:9292/auth/bootic/callback'

There's an example app in [spec/app.rb](/atmos/warden-bootic/blob/master/spec/app.rb).

The Extension in Action
=======================
    % gem install bundler
    % bundle install
    % OAUTH_CLIENT_ID="<from Bootic>" OAUTH_CLIENT_SECRET="<from Bootic>" bundle exec rackup
