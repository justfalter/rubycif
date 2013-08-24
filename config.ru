require 'rubycif/api'
require 'rack/reverse_proxy'

proxy = Rack::ReverseProxy.new do
  reverse_proxy_options :timeout => 300
  reverse_proxy '/', 'http://127.0.0.1/'
end 

app = RubyCif::API.new(proxy)

run app
