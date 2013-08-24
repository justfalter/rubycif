
All this does is act as a proxy for the CIF API, at the moment. 
It expects the CIF API to be listening on http://127.0.0.1/api

Requires:
  jruby 1.7.x
  google protobuf (tested with 2.5)


Steps for getting things going:

1. bundle install
2. bundle exec rake 
3. bundle exec rackup

You should now have an HTTP service listening on tcp port 9292. Configure
your CIF client to communicate with http://yourhost:9292/api, and query away.
