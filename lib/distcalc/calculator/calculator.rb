require_relative './infix_to_postfix'
require_relative './postfix_calculator'
require_relative './scanner'


module Calculator
  class Maincalculator
    def initialize()
      @scanner = Calculator::Scanner.new
      @conv = Calculator::InfixToPostfix.new
      @calc = Calculator::PostfixMachine.new(
                { add:  Calculator::Addition.new,
                  sub:  Calculator::Subtraction.new,
                  mult: Calculator::Multiplication.new,
                  div:  Calculator::Division.new})
    end

    #get the user input from keyboard
    def read_and_calculate()
        puts "Insert the equation"
        entry = gets.chomp
        result = calculate(entry)
        puts "Result --->  " + result.to_s
    end

    #calculate based on a string... good for testing purposes
    def calculate(entry)
        expr = @scanner.scan(entry)
        expressao = @conv.to_postfix(expr)
        @calc.eval(expressao)
    end

  end
end
