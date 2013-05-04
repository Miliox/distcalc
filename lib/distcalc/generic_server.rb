# encoding: UTF-8
require 'socket'
require_relative './util/log'

# Generic Server implementation responsible only for communication aspects.
# it delegates the request to a request handler wich must have a
# handle_request method
class GenericServer
  def initialize(request_handler, port = 2000)
    UTIL::Log.info("start server on port: #{port}")
    @server = TCPServer.new port
    @request_handler = request_handler
  end

  #Starts listen for client connections
  #
  def start
    UTIL::Log.info('waiting clients')
    loop do
      Thread.start(@server.accept) do |client|
        UTIL::Log.info("accepted connection from #{client.peeraddr(false)[3]}")
        request = client.gets
        UTIL::Log.info("received request #{request}")
	response = @request_handler.handle_request(request)
        UTIL::Log.info("send response #{response}")
	client.puts response
        client.close
        UTIL::Log.info("closed connection")
      end
    end

  end

end
