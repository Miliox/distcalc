# encoding: UTF-8
#Responsible for perform an arithmetic operation given the configured operator
require_relative './generic_server'
require_relative './calculator/math_operations'

class EvalHandler

  def initialize(operator)
    @operator = operator
  end

  # handle the request TODO create an object to handle the protocol
  def handle_request(request)
    calculate(parse_request(request))
  end

  # Takes the raw data received from the socket and convert
  # it to a format used to perform de calculation
  #
  # @param data in the format defined by the communication protocol.
  # @return [Hashtable] the data ready to calculus.
  def parse_request(request)
    return request.split(':')
  end

  # Perform the calculus defined for the current instance of the evalsever.
  #
  # @param expr The operands in a hashtable
  # @return [Number] the result of the calculus
  def calculate(expr)
    operando1 = expr[0].to_i
    operando2 = expr[1].to_i
    puts operando1, operando2
    @operator.eval(operando1, operando2)
  end

end

server = GenericServer.new EvalHandler.new(Calculator::Addition.new), 2001
server.start()
