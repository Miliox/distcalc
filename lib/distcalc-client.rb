# encoding: utf-8
require_relative "./distcalc/version"
require_relative "./distcalc/eval_handler"
#require_relative "./distcalc/generic_server" # enquanto nao esta configurado
require 'optparse'
       OPTS = {}

       op = OptionParser.new do |x|
           x.banner = ''
           x.separator ''
           OPTS[:server] = 'localhost'
           OPTS[:calc] = false

           x.on('-c', '--calc', String, 'server that evaluate expression') do |s|
              OPTS[:calc] = true
           end

           x.on('-s', '--server', String, 'server that evaluate expression') do |s|
              OPTS[:server] = s
           end

            x.on('-m', '--math expr', String, 'math expression to evaluate') do |expr|
               OPTS[:expr] = expr
           end

       end
       op.parse!(ARGV)
       if OPTS[:calc] = true
            #executa client        
       end
       OPTS[:calc]
end
