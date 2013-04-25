require 'distcalc/calculator/calculator'
require 'test/unit'

class TestIntegration < Test::Unit::TestCase
  def setup
    @calc = Calculator::Maincalculator.new
  end

  def test__resolve_equation
    assert_equal(15, @calc.calculate("3 + 4 * 3"))
    assert_equal(55, @calc.calculate("5 * 10 * 2 - 3 * 15"))
    #assert_equal(23, @calc.calculate("3 + 7 - 9 * 1 + 22"))
    #assert_equal(15, @calc.calculate("(6 + 4) + (5 * 4) / 2"))
  end

end
