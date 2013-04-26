require "./distcalc/version"
require "./distcalc/evalserver"

module Distcalc
  # Your code goes here...
end

echoServer = GenericServer.new EchoHanlder.new
echoServer.start()