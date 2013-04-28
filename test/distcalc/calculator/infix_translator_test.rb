# encoding: utf-8
require 'distcalc/calculator/infix_translator'
require 'test/unit'

class TestInfixTranslator < Test::Unit::TestCase
  def setup
    @conv = Calculator::InfixTranslator.new
  end

  def test__to_postfix__example1__return_postfix_expression
    expr   = [3, :add, 4, :mult, 5, :div, 6]
    expect = [3, 4, 5, :mult, 6, :div, :add]

    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__to_postfix__example2__return_postfix_expression
    expr = [:open_bracket, 300, :add, 23, :close_bracket] +
           [:mult] +
           [:open_bracket, 43, :sub, 21, :close_bracket] +
           [:div] +
           [:open_bracket, 84, :add, 7, :close_bracket]
    expect = [300, 23, :add, 43, 21, :sub, :mult, 84, 7, :add, :div]
    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__to_postfix__example3__return_postfix_expression
    expr = [:open_bracket, 4, :add, 8, :close_bracket] +
           [:mult] + [:open_bracket, 6, :sub, 5, :close_bracket] +
           [:div] + [:open_bracket] +
           [:open_bracket, 3, :sub, 2, :close_bracket] +
           [:mult, :open_bracket, 2, :add, 2, :close_bracket] +
           [:close_bracket]
    expect = [4, 8, :add, 6, 5, :sub, :mult, 3, 2] +
             [:sub, 2, 2, :add, :mult, :div]
    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__expr_without_any_brackets
    expr = [1, :add, 6, :add, 5, :mult, 10, :sub, 7, :div, 7]
    expect = [1, 6, :add, 5, 10, :mult, :add, 7, 7, :div, :sub]
    assert_equal(expect, @conv.to_postfix(expr))
  end

  def test__expr_start_posneg_number__return_postfix_expression_with_zeros
    expr1 = [:add, 6 , :sub, 3]
    expect1 = [0, 6, :add, 3, :sub]

    expr2 = [:sub, 6 , :sub, 3]
    expect2 = [0, 6, :sub, 3, :sub]

    assert_equal(expect1, @conv.to_postfix(expr1))
    assert_equal(expect2, @conv.to_postfix(expr2))
  end

  def test__expr_with_bracket_posneg_number__return_postfix_expression_with_zeros
    expr1 = [:open_bracket, :add, 6, :sub, 3, :close_bracket]
    expect1 = [0, 6, :add, 3, :sub]

    expr2 = [6 , :sub, 3, :add, :open_bracket, :add, 1, :close_bracket]
    expect2 = [6, 3, :sub, 0, 1, :add, :add]

    assert_equal(expect1, @conv.to_postfix(expr1))
    assert_equal(expect2, @conv.to_postfix(expr2))
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
