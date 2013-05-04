# encoding: utf-8
require_relative './expression_tokenizer'
require_relative './infix_translator'
require_relative './postfix_machine'
require_relative '../util/log'

module Calculator
  class Maincalculator
    def initialize(
      add =  Calculator::Addition.new,
      sub =  Calculator::Subtraction.new,
      mult = Calculator::Multiplication.new,
      div =  Calculator::Division.new
    )
      @scanner = Calculator::ExpressionTokenizer.new
      @translate = Calculator::InfixTranslator.new
      @calc = Calculator::PostfixMachine.new(
	 {:add => add, :sub => sub, :mult => mult, :div => div})
    end

    #get the user input from keyboard
    def read_and_calculate
        puts 'Insert the equation'
        entry = gets.chomp
        result = calculate(entry)
        puts result
    end

    #calculate based on a string... good for testing purposes
    def calculate(input)
	UTIL::Log.debug("processing: #{input}")
        expr = @scanner.tokenize(input)
	UTIL::Log.debug("tokenized expression: #{expr}")
        postfix_expr = @translate.to_postfix(expr)
	UTIL::Log.debug("postfix expression: #{postfix_expr}")
        result = @calc.eval(postfix_expr)
        UTIL::Log.debug("result: #{result}")
	result
    end

  end
end
