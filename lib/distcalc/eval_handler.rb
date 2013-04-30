# encoding: UTF-8
#Responsible for perform an arithmetic operation given the configured operator
class EvalHandler

  def initialize(operator = 'add')
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
    return {
      'operador1' => 409,
      'operador2' => 700
    }
  end

  # Perform the calculus defined for the current instance of the evalsever.
  #
  # @param expr The operands in a hashtable
  # @return [Number] the result of the calculus
  def calculate(expr)
    if @operator == 'add'
      return expr['operador1'] + expr['operador2']
    elsif @operator == 'sub'
      return expr['operador1'] - expr['operador2']
    elsif @operator == 'div'
      return expr['operador1'] / expr['operador2'] # esta truncando o valor !!!
    elsif @operator == 'mul'
      return expr['operador1'] * expr['operador2']
    end
  end

end