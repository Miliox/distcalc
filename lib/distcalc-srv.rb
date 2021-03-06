# encoding: utf-8
require 'optparse'
require 'logger'
require 'yaml'

require_relative './distcalc/version'
require_relative './distcalc/server_handler'
require_relative './distcalc/util/log'

def execute_server
  op = OptionParser.new do |x|
    x.banner = 'distcalc server --port <port> --config-file <file.yaml>'
    x.separator ''
    OPTS[:port] = 6416
    OPTS[:config] = 'nodesconfig'

    x.on('-p', '--port PORT', Numeric, 'port to connect to') do |p|
      OPTS[:port] = p
    end

    x.on('-c', '--config-file CONFIG', String, 'configuration of the nodes') do |c|
      OPTS[:config] = c
    end

  end
  op.parse!(ARGV)

  UTIL::Log.debug("server parameter: #{OPTS}")
  config = YAML::load_file(OPTS[:config])
  UTIL::Log.debug("config: #{config}")

  UTIL::Log.info("Launch server on #{OPTS[:port]}")
  server = GenericServer.new ServerHandler.new(config), OPTS[:port]
  server.start()
end

