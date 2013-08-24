require 'base64'
require 'stringio'
require 'snappy-jars'
require 'protobuf'
require 'rubycif/protocols/cif.pb'
require 'rubycif/protocols/iodef.pb'

module RubyCif
  def self.process_opts(data, opts = {})
    opts = {
      base64:  true,
      compressed: true
    }.merge(opts)

    if opts[:base64] == true
      data = Base64.decode64(data)
    end
    if opts[:compressed] == true
      data = org.xerial.snappy.Snappy.uncompress(data.to_java_bytes).to_s
    end
    data
  end

  def self.decode_iodef_doc(data, opts = {})
    data = process_opts(data, opts)
    RubyCif::Protocols::IODEF::IODEF_DocumentType.decode(data)
    #com.rubycif.protocols.Iodef::IODEF_DocumentType.parseFrom(bytes)
  end 

  def self.decode_msg_query(data)
    RubyCif::Protocols::CIF::MessageType::QueryType.decode(data)
  end 

  def self.decode_msg_data(msg)
    case msg.type
    when RubyCif::Protocols::CIF::MessageType::MsgType::QUERY
      msg.data.map {|x| decode_msg_query(x)}
    when RubyCif::Protocols::CIF::MessageType::MsgType::SUBMISSION
      msg.data.map {|x| decode_iodef_doc(x)}
    when RubyCif::Protocols::CIF::MessageType::MsgType::RESPONSE
      raise "NOPE"
    end 
  end 

  def self.decode_msg(data, opts = {})
    data = process_opts(data, opts)
    RubyCif::Protocols::CIF::MessageType.decode(data)
  end 
end 
