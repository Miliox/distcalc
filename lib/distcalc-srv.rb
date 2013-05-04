# encoding: utf-8
require "./distcalc/version"
require "./distcalc/server_handler"
require 'optparse'
require 'logger'
require 'yaml'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO

def execute_server
  op = OptionParser.new do |x|
    x.banner = ''
    x.separator ''
    OPTS[:port] = '6416'
    OPTS[:config] = 'nodesconfig'

    x.on('-p', '--port PORT', String, 'port to connect to') do |p|
      OPTS[:port] = p
    end

    x.on('-c', '--config CONFIG', String, 'configuration of the nodes') do |c|
      OPTS[:config] = c
    end

  end
  op.parse!(ARGV)
  config = YAML::load(File.open(OPTS[:config]))
  server = GenericServer.new ServerHandler.new(config), OPTS[:port] 
  server.start()
end

