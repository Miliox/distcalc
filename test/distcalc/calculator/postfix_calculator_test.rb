require 'distcalc/calculator/postfix_calculator'
require 'test/unit'

class TestPostfixCalculator < Test::Unit::TestCase
  def setup
    @calc = Calculator::PostfixMachine.new(
            {add:  Calculator::Addition.new,
             sub:  Calculator::Subtraction.new,
             mult: Calculator::Multiplication.new,
             div:  Calculator::Division.new})
  end

  def test__eval_basic_expression__return_result
    assert_equal(5, @calc.eval([2, 3, :add]))
    assert_equal(8, @calc.eval([9, 1, :sub]))
    assert_equal(4, @calc.eval([2, 2, :mult]))
    assert_equal(1, @calc.eval([3, 3, :div]))
  end

  def test__eval_complex_expression__return_result
    expr1 = [3, 4, 5, :mult, 6, :div, :add]
    expr2 = [300, 23, :add, 43, 21, :sub, :mult, 84, 7, :add, :div]
    expr3 = [4, 8, :add, 6, 5, :sub, :mult, 3, 2, :sub, 2, 2, :add,
             :mult, :div]
    expr4 = [1,6,:add,5,10,:mult,7,7,:div,:sub,:add]

    assert_equal(6, @calc.eval(expr1))
    assert_equal(78, @calc.eval(expr2))
    assert_equal(3, @calc.eval(expr3))
    assert_equal(56, @calc.eval(expr4))
  end
end
