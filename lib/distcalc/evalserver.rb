# encoding: UTF-8
require 'socket'
require 'logger'

$log = Logger.new(STDOUT)
$log.level = Logger::INFO


# EvalServer implementation
class EvalServer

  def initialize(operator = 'add', port = 2000)
    $log.info("initialising EvalServer for
      #{operator} operation on port: #{port}")
    @server = TCPServer.new port # Server bound to port 2000
    @operator = operator
  end

  #Starts listen for client connections
  #
  def start
    $log.info('waiting for client connections')
    loop do
      Thread.start(@server.accept) do |client|
        request = client.gets
        $log.info("evaluating expression #{request} from client #{client}")
        expr = self.parse_request(request)
        client.puts self.calculate(expr)
        client.close
      end
    end

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