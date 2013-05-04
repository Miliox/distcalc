# encoding: utf-8
require 'optparse'
require_relative './distcalc/client'
require_relative './distcalc/util/log'

def execute_client
  op = OptionParser.new do |x|
    x.banner = 'distcalc calc [--server <ip|uri>] [--port <port>] --eval <EXPR>'
    x.separator ''
    OPTS[:server] = 'localhost'
    OPTS[:port] = 6416

    x.on('-p', '--port PORT', Numeric, 'port to connect to') do |p|
      OPTS[:port] = p
    end

    x.on('-s', '--server SERVER', String, 'server that evaluate expression') do |s|
      OPTS[:server] = s
    end

    x.on('-e', '--eval EXPR', String, 'math expression to evaluate') do |expr|
      OPTS[:expr] = expr
    end

  end
  op.parse!(ARGV)
  UTIL::Log.debug("client parameters: #{OPTS}")

  client = Client.new OPTS[:server], OPTS[:port]
  UTIL::Log.info("connected to #{OPTS[:server]} by port #{OPTS[:port]}")
  UTIL::Log.info("processing expression: #{OPTS[:expr]}")
  client.calculate(OPTS[:expr])
end

