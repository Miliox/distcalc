require 'distcalc/calculator/infix_to_postfix'
require 'test/unit'

class TestInfixToPostfix < Test::Unit::TestCase
  def setup
    @conv = Calculator::InfixToPostfix.new
  end

  def test__to_postfix__example1__return_postfix_expression
    expr = [3, :add, 4, :mult, 5, :div, 6]
    expect = [3, 4, 5, :mult, 6, :div, :add]

    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__to_postfix__example2__return_postfix_expression
    expr = [:open_bracket, 300, :add, 23, :close_bracket,
            :mult, :open_bracket, 43, :sub, 21, :close_bracket,
            :div, :open_bracket, 84, :add, 7, :close_bracket]
    expect = [300, 23, :add, 43, 21, :sub, :mult, 84, 7, :add, :div]

    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__to_postfix__example3__return_postfix_expression
    expr = [:open_bracket, 4, :add, 8, :close_bracket,
            :mult,
            :open_bracket, 6, :sub, 5, :close_bracket,
            :div, :open_bracket,
            :open_bracket, 3, :sub, 2, :close_bracket,
            :mult, :open_bracket, 2, :add, 2, :close_bracket,
            :close_bracket]
    expect = [4, 8, :add, 6, 5, :sub, :mult, 3, 2,
              :sub, 2, 2, :add, :mult, :div]

    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__expr_without_any_brackets
    expr = [1, :add, 6, :add, 5, :mult, 10, :sub, 7, :div, 7]
    expect = [1, 6, :add, 5, 10, :mult, 7, 7, :div, :sub, :add]

    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__to_postfix__common_errors__raise_standard_error
    assert_raise(StandardError) do
      @conv.to_postfix([:open_bracket, 9, :add, 4])
    end
    assert_raise(StandardError) do
      @conv.to_postfix([9, :add, 4, :close_bracket])
    end
    assert_raise(StandardError) do
      @conv.to_postfix([9, 'add', 4, :close_bracket])
    end
  end
end
