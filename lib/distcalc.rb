# encoding: utf-8
require "./distcalc-calc"
require "./distcalc-eval"
require "./distcalc-srv"

OPTS = {}
if ARGV[0] == 'calc'
   execute_client()
elsif ARGV[0] == 'eval'
  execute_evalserver()
elsif  ARGV[0] == 'server'
  execute_server()
end

