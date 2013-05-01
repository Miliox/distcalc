# encoding: UTF-8
require 'socket'
require './calculator/math_operations'

module Network

  module Client
    def initialize(host = 'localhost', port = 2000)
      @host = host
      @port = port
    end

    def send(input)
      puts input
      @server = TCPSocket.new @host, @port
      @server.puts input
      response = @server.gets
      @server.close()
      response
    end
  end
  
  class OperationStub < Calculator::BinaryOperation
      include Network::Client
      def eval(arg1, arg2) 
        send("#{arg1}:#{arg2}")
      end
    end

end

