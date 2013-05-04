# encoding: UTF-8
require 'socket'
require_relative './calculator/math_operations'
require_relative './util/log'

module Network
  module Client
    def initialize(host = 'localhost', port = 2000)
      UTIL::Log.info("start client that connect to #{host}:#{port}")
      @host = host
      @port = port
    end

    def send(input)
      server = TCPSocket.new @host, @port
      UTIL::Log.debug("connected to #{@host}:#{@port}")
      server.puts input
      UTIL::Log.debug("sent #{input}")
      response = server.gets
      UTIL::Log.debug("received #{response}")
      server.close()
      UTIL::Log.debug("closed connection")
      response.to_i
    end
  end

  class OperationStub < Calculator::BinaryOperation
      include Network::Client
      def eval(arg1, arg2)
        UTIL::Log.debug("arg1: #{arg1}")
        UTIL::Log.debug("arg2: #{arg2}")
        send("#{arg1}:#{arg2}")
      end
    end

end

