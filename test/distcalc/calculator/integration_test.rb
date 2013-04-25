require 'distcalc/calculator/infix_to_postfix'
require 'distcalc/calculator/postfix_calculator'
require 'test/unit'

class TestInfixToPostfix < Test::Unit::TestCase
  def setup
    @scanner = Calculator::Scanner.new
    @conv = Calculator::InfixToPostfix.new
    @calc = Calculator::PostfixMachine.new(
            {add:  Calculator::Addition.new,
             sub:  Calculator::Subtraction.new,
             mult: Calculator::Multiplication.new,
             div:  Calculator::Division.new})
  end

  def test__resolve_expr__scanned

    expr = @scanner.scan('1 + 6 + 5 * 10 - 7 / 7')
    expressao = @conv.to_postfix(expr)

    assert_equal(56, @calc.eval(expressao))

    expr = @scanner.scan('6 * 7 + 7 - 6 / 3 * 4')
    expressao = @conv.to_postfix(expr)

    assert_equal(41, @calc.eval(expressao))
  end

end
