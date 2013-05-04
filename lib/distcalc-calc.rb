# encoding: utf-8
require "./distcalc/client" # enquanto nao esta configurado

require 'optparse'
require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO

def execute_client
  op = OptionParser.new do |x|
    x.banner = ''
    x.separator ''
    OPTS[:server] = 'localhost'
    OPTS[:port] = '6416'

    x.on('-p', '--port PORT', String, 'port to connect to') do |p|
      OPTS[:port] = p
    end

    x.on('-s', '--server SERVER', String, 'server that evaluate expression') do |s|
      OPTS[:server] = s
    end

    x.on('-m', '--math EXPR', String, 'math expression to evaluate') do |expr|
      OPTS[:expr] = expr
    end

  end
  op.parse!(ARGV)
  $log.info("executando calculo #{OPTS[:expr]}")
  client = Client.new OPTS[:server], OPTS[:port]
  client.calculate(OPTS[:expr])
end

