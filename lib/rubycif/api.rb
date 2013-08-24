require 'sinatra'
require 'pp'
require 'rubycif/protocols'
# Effectively disable form data parsing.
Rack::Request::FORM_DATA_MEDIA_TYPES.clear

module RubyCif
  class API < Sinatra::Base
    post '/api' do
      puts "Got a request"
      request.body.rewind
      data = request.body.read
      request.body.rewind
      start = Time.now
      msg = RubyCif.decode_msg(data, :base64 => false, :compressed => false)
      puts "Decode time: #{Time.now - start}"
      request.body.rewind

      case msg.type
      when RubyCif::Protocols::CIF::MessageType::MsgType::QUERY
        puts "Forwarding query"
        pp RubyCif.decode_msg_data(msg)
        forward

      when RubyCif::Protocols::CIF::MessageType::MsgType::SUBMISSION
        puts "Forwarding submission"
        forward
      else 
        puts "Unknown! #{msg.type}"
        forward
      end 
    end 
  end
end
