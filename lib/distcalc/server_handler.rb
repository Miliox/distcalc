# encoding: UTF-8
require './calculator/calculator'
require './generic_server'
require './network'

class ServerHandler

  def initialize
    @main_calculator = Calculator::Maincalculator.new(Network::OperationStub.new('localhost', 2001))
  end
  
  def handle_request(request)
    @main_calculator.calculate(request)
  end
  
end

server = GenericServer.new ServerHandler.new
server.start()
