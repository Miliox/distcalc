require "../../lib/distcalc/evalserver"
require "test/unit"
 
class TestEvalServer < Test::Unit::TestCase
 
  def teste_wtf
    evalServer = EvalServer.new #ARGV[0], ARGV[1]
    result = evalServer.calculate({'operador1'=> 100, 'operador2'=>100})
    assert_equal(200, result)
  end
 
end