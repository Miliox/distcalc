# encoding: UTF-8
require_relative './calculator/calculator'
require_relative './generic_server'
require_relative './network'

class ServerHandler
  def initialize(config)
    add = Network::OperationStub.new(config['add']['server'], config['add']['port'])
    sub = Network::OperationStub.new(config['sub']['server'], config['sub']['port'])
    mul = Network::OperationStub.new(config['mul']['server'], config['mul']['port'])
    div = Network::OperationStub.new(config['div']['server'], config['div']['port'])
    @main_calculator = Calculator::Maincalculator.new(add, sub, mul, div)
  end
  
  def handle_request(request)
    @main_calculator.calculate(request)
  end
  
end

