# encoding: utf-8
require 'logger'
require 'optparse'
require_relative './distcalc/client'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO

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

  $log.info("executando calculo #{OPTS[:expr]}")
  client = Client.new OPTS[:server], OPTS[:port]
  client.calculate(OPTS[:expr])
end

