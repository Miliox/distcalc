# encoding: utf-8
require_relative "./distcalc/version"
require_relative "./distcalc/eval_handler"
#require_relative "./distcalc/generic_server" # enquanto nao esta configurado
require 'optparse'

OPTS = {}

op = OptionParser.new do |x|
    x.banner = 'cat <options> <file>'      
    x.separator ''
    OPTS[:server] = 'localhost'

    x.on('-s', '--server', String, 'server that evaluate expression') do |s|
       OPTS[:server] = s
    end

     x.on('-m', '--math expr', String, 'math expression to evaluate') do |expr|
        OPTS[:expr] = expr
    end

end
op.parse!(ARGV)

module Distcalc
  # Your code goes here...
end

