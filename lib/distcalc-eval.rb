# encoding: utf-8
require 'logger'
require 'optparse'

require_relative './distcalc/eval_handler'
require_relative './distcalc/version'
require_relative './distcalc/calculator/math_operations'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO

def execute_evalserver
  op = OptionParser.new do |x|
    x.banner = 'distcalc eval --type <add|sub|mul|div> --port <port>'
    x.separator ''
    OPTS[:port] = 3741
    OPTS[:type] = 'add'

    x.on('-p', '--port PORT', Numeric, 'port to listen on') do |p|
      OPTS[:port] = p
    end

    x.on('-t', '--type TYPE', String, 'the type of math operation') do |t|
      OPTS[:type] = t
    end
  end

  op.parse!(ARGV)

  operation = nil
  if OPTS[:type] == 'add'
    operation = Calculator::Addition.new
  elsif OPTS[:type] == 'sub'
    operation = Calculator::Subtraction.new
  elsif OPTS[:type] == 'mul'
    operation = Calculator::Multiplication.new
  elsif OPTS[:type] == 'div'
    operation = Calculator::Division.new
  else
    puts 'distcalc eval --type <add|sub|mul|div> --port <port>'
    return
  end

  $log.info("selected operation to eval: #{OPTS[:type]} on port #{OPTS[:port]}")
  server = GenericServer.new EvalHandler.new(operation), OPTS[:port]
  server.start()
end

