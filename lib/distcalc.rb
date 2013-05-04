# encoding: utf-8
require_relative './distcalc-calc'
require_relative './distcalc-eval'
require_relative './distcalc-srv'
require_relative './distcalc/util/log'

if ARGV.include? '--verbose'
  UTIL::Log.level(UTIL::LOG_INFO)
  ARGV.delete('--verbose')
end
if ARGV.include? '--trace'
  UTIL::Log.level(UTIL::LOG_DEBUG)
  ARGV.delete('--trace')
end

OPTS = {}
if ARGV[0] == 'calc'
   execute_client()
elsif ARGV[0] == 'eval'
  execute_evalserver()
elsif  ARGV[0] == 'server'
  execute_server()
else
  puts 'Usage:'
  puts 'distcalc calc -s|--server <ip|uri> -p|--port <port> -e|--eval <expr>'
  puts 'distcalc eval -t|--type add|sub|mul|div -p|--port <port>'
  puts 'distcalc server -p|--port <port> -c|--config-file <file.yaml>'
  puts 'use --verbose for more details'
  puts 'use --trace for debug info'
end

