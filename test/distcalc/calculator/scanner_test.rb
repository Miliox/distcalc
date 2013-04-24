require 'distcalc/calculator/scanner'
require 'test/unit'

class TestScanner < Test::Unit::TestCase
  def setup
    @scanner = Calculator::Scanner.new
  end

  def test__scan__string_one_number__return_array_with_number
    assert_equal([1], @scanner.scan('1'))
    assert_equal([2], @scanner.scan('2'))
    assert_equal([3], @scanner.scan('3'))
    assert_equal([4], @scanner.scan('4'))
    assert_equal([5], @scanner.scan('5'))
    assert_equal([6], @scanner.scan('6'))
    assert_equal([7], @scanner.scan('7'))
    assert_equal([8], @scanner.scan('8'))
    assert_equal([9], @scanner.scan('9'))
  end

  def test__scan__string_sequence_number__return_array_with_number
    assert_equal([12], @scanner.scan('12'))
    assert_equal([123], @scanner.scan('123'))
    assert_equal([1234], @scanner.scan('1234'))
    assert_equal([12_345], @scanner.scan('12345'))
    assert_equal([123_456], @scanner.scan('123456'))
  end

  def test__scan__string_simple_expression__return_array_with_tokens
    assert_equal([1, :add, 2], @scanner.scan('1+2'))
    assert_equal([40, :sub, 15], @scanner.scan('40 - 15'))
    assert_equal([100, :mult, 2], @scanner.scan('100* 2'))
    assert_equal([93, :div, 3], @scanner.scan('93 /3'))
    assert_equal([:open_bracket, :add, 3, :close_bracket],
                 @scanner.scan('(+3)'))
    assert_equal([:open_bracket, :sub, 5, :close_bracket],
                 @scanner.scan('(-5)'))
  end

  def test__scan__invalid_character_in_expression__raise_scanner_error
    assert_raise(Calculator::ScannerError) { @scanner.scan('123.45') }
    assert_raise(Calculator::ScannerError) { @scanner.scan('05 + 3 - 2 - FF') }
    assert_raise(Calculator::ScannerError) { @scanner.scan('05 + 4 \\ 2') }
    assert_raise(Calculator::ScannerError) { @scanner.scan('14 _ 3') }
    assert_raise(Calculator::ScannerError) { @scanner.scan('4586 * [4]') }
  end

end
