# encoding: UTF-8
require 'socket'
require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO


# Generic Server implementation responsible only for communication aspects.
# it delegates the request to a request handler wich must have a
# handle_request method

class GenericServer

  def initialize(request_handler, port = 2000)
    raise ArgumentError #unless request_handler != nil
    $log.info("initialising server on port: #{port}")
    @server = TCPServer.new port
    @request_handler = request_handler
  end

  #Starts listen for client connections
  #
  def start
    $log.info('waiting for client connections')
    loop do
      Thread.start(@server.accept) do |client|
        request = client.gets
        $log.info("received request #{request} from client #{client}")
        client.puts @request_handler.handle_request(request)
        client.close
      end
    end

  end

end