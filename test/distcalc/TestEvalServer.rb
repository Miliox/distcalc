require "../../lib/distcalc/generic_server"
require "test/unit"
 
class TestGenericServer < Test::Unit::TestCase
 
  def teste_initialise
    assert_raise ArgumentError do
      genericServer = GenericServer.new
    end
  end
 
end