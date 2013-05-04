# encoding: utf-8
require "./distcalc/version"
require "./distcalc/eval_handler"
require 'optparse'

OPTS = {}

op = OptionParser.new do |x|
    x.banner = 'cat <options> <file>'      
    x.separator ''

    x.on("-c", "--calc", "calcular expressao") \
        { OPTS[:calc] = true }      
    x.on('-s', '--server SERVER', String, 'servidor') do |server|
        OPTS[:server] = server 
    end

     x.on('-m', '--math expr', String, 'servidor') do |expr|
        OPTS[:expr] = expr
    end

end
op.parse!(ARGV)

if OPTS[:calc]
   puts 'fazendoo conta no servidor', OPTS[:server], OPTS[:expr]
end


if OPTS[:server]

   puts 'imprimir port, arquivo de config'
end
module Distcalc
  # Your code goes here...
end

