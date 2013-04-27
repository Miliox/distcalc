require_relative './expression_tokenizer'
require_relative './math_operations'

module Calculator
  # Stack Based Processor that evaluate a Postfix sequence of instructions
  # Numbers are put on stack
  # Operation are apply last two stacked number and result put back on stack
  #
  # @author Emiliano Firmino
  class PostfixMachine
    def initialize(supported_operations)
      raise unless supported_operations.is_a? Hash
      supported_operations.each_pair do |key, value|
        raise unless key.is_a? Symbol
        raise unless value.is_a? BinaryOperation
      end

      @operator = supported_operations
    end

    # Evaluate a postfix math expression
    #
    # @param expr [Array<Number, Symbol>] the postfix tokenizied expression
    # @return [Number] result of expr
    # @raise [StandardError] when something wrong
    def eval(expr)
      @stack = Array.new

      expr.each do |t| @stack.push(t)
        execute_operation if t.is_a? Symbol
        raise StandardError.new "invalid token #{token}" \
          unless t.is_a? Numeric or t.is_a? Symbol
      end

      raise StandardError.new 'invalid math expression' \
        unless @stack.size == 1

      @stack.pop
    end

    private
    def execute_operation
      op, arg2, arg1 = @stack.pop, @stack.pop, @stack.pop

      raise StandardError.new "not supported operation #{token}" \
        unless @operator.keys.include? op

      @stack.push(@operator[op].eval(arg1, arg2))
    end
  end
end
