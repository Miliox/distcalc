# encoding: UTF-8
require 'socket'
require_relative './calculator/math_operations'

require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO


module Network

  module Client
    def initialize(host = 'localhost', port = 2000)
      $log.info("inicializando client, vai acessar #{host}:#{port}")
      @host = host
      @port = port
    end

    def send(input)
      puts input
      @server = TCPSocket.new @host, @port
      @server.puts input
      response = @server.gets
      @server.close()
      response.to_i
    end
  end
  
  class OperationStub < Calculator::BinaryOperation
      include Network::Client
      def eval(arg1, arg2) 
        send("#{arg1}:#{arg2}")
      end
    end

end

