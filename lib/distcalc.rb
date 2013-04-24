require "./distcalc/version"
require "./distcalc/evalserver"

module Distcalc
  # Your code goes here...
end


evalServer = EvalServer.new #ARGV[0], ARGV[1]
evalServer.start()
