# encoding: utf-8
require_relative './expression_tokenizer'
require_relative './infix_translator'
require_relative './postfix_machine'


module Calculator
  class Maincalculator
    def initialize(
      add =Calculator::Addition.new,
      sub =Calculator::Subtraction.new,
      mult =Calculator::Multiplication.new,
      div = Calculator::Division.new
    )
      @scanner = Calculator::ExpressionTokenizer.new
      @conv = Calculator::InfixTranslator.new
      @calc = Calculator::PostfixMachine.new({
                  :add =>  add,
                  :sub =>  sub,
                  :mult => mult,
                  :div =>  div})
    end

    #get the user input from keyboard
    def read_and_calculate
        puts 'Insert the equation'
        entry = gets.chomp
        result = calculate(entry)
        puts 'Result --->  ', result.to_s
    end

    #calculate based on a string... good for testing purposes
    def calculate(entry)
        expr = @scanner.tokenize(entry)
        expressao = @conv.to_postfix(expr)    
        @calc.eval(expressao)
    end

  end
end
