require 'distcalc/calculator/expression_tokenizer'
require 'test/unit'

class TestExpressionTokenizer < Test::Unit::TestCase
  def setup
    @t = Calculator::ExpressionTokenizer.new
  end

  def test__tokenize__string_one_number__return_array_with_number
    assert_equal([1], @t.tokenize('1'))
    assert_equal([2], @t.tokenize('2'))
    assert_equal([3], @t.tokenize('3'))
    assert_equal([4], @t.tokenize('4'))
    assert_equal([5], @t.tokenize('5'))
    assert_equal([6], @t.tokenize('6'))
    assert_equal([7], @t.tokenize('7'))
    assert_equal([8], @t.tokenize('8'))
    assert_equal([9], @t.tokenize('9'))
  end

  def test__tokenize__string_sequence_number__return_array_with_number
    assert_equal([12], @t.tokenize('12'))
    assert_equal([123], @t.tokenize('123'))
    assert_equal([1234], @t.tokenize('1234'))
    assert_equal([12_345], @t.tokenize('12345'))
    assert_equal([123_456], @t.tokenize('123456'))
  end

  def test__tokenize__string_simple_expression__return_array_with_tokens
    assert_equal([1, :add, 2], @t.tokenize('1+2'))
    assert_equal([40, :sub, 15], @t.tokenize('40 - 15'))
    assert_equal([100, :mult, 2], @t.tokenize('100* 2'))
    assert_equal([93, :div, 3], @t.tokenize('93 /3'))
    assert_equal([:open_bracket, :add, 3, :close_bracket],
                 @t.tokenize('(+3)'))
    assert_equal([:open_bracket, :sub, 5, :close_bracket],
                 @t.tokenize('(-5)'))
    assert_equal([1, :add, 6, :add, 5, :mult, 10, :sub, 7, :div, 7],
                 @t.tokenize('1 + 6 + 5 * 10 - 7 / 7'))
  end

  def test__tokenize__invalid_character_in_expression__raise_scanner_error
    assert_raise(Calculator::ScannerError) { @t.tokenize('123.45') }
    assert_raise(Calculator::ScannerError) { @t.tokenize('05 + 3 - 2 - FF') }
    assert_raise(Calculator::ScannerError) { @t.tokenize('05 + 4 \\ 2') }
    assert_raise(Calculator::ScannerError) { @t.tokenize('14 _ 3') }
    assert_raise(Calculator::ScannerError) { @t.tokenize('4586 * [4]') }
  end

end
