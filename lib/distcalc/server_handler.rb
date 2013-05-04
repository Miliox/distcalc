# encoding: UTF-8
require_relative './calculator/calculator'
require_relative './generic_server'
require_relative './network'

class ServerHandler

  def initialize(config)
    addStub = Network::OperationStub.new(config['add']['server'], config['add']['port'])
    subStub = Network::OperationStub.new(config['sub']['server'], config['sub']['port'])
    mulStub = Network::OperationStub.new(config['mul']['server'], config['mul']['port'])
    divStub = Network::OperationStub.new(config['div']['server'], config['div']['port'])
    @main_calculator = Calculator::Maincalculator.new(addStub, subStub, mulStub, divStub)
  end
  
  def handle_request(request)
    @main_calculator.calculate(request)
  end
  
end

