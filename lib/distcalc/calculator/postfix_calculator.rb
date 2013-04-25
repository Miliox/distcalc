require_relative './scanner'
require_relative './infix_to_postfix'
require_relative './math_operations'

module Calculator
  class PostfixMachine
    def initialize(supported_operations)
      raise unless supported_operations.is_a? Hash
      supported_operations.each_pair do |key, value|
        raise unless key.is_a? Symbol
        raise unless value.is_a? BinaryOperation
      end

      @operator = supported_operations
    end

    def eval(math_expr)
      stack = Array.new
      math_expr.each do |token|
        stack.push(token)
        if @operator.keys.include? stack.last
          eval_operator(stack)
        elsif token.is_a? Numeric
        elsif token_is_a? Symbol
          raise StandardError.new "not supported operation #{token}"
        else
          raise StandardError.new "invalid token #{token}"
        end
      end

      if stack.size == 1
        stack.last
      else
        raise StandardError.new 'invalid math expression'
      end
    end

    def eval_operator(stack)
      oper = stack.pop
      op2  = stack.pop
      op1  = stack.pop
      stack.push(@operator[oper].eval(op1, op2))
    end
  end
end
