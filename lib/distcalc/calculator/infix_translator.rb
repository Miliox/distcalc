# encoding: utf-8
require_relative './expression_tokenizer'

module Calculator
  class InfixTranslator
    OP_POP_PRIORY = {:add => 1, :sub => 1, :mult=> 2, :diV=>2, :open_bracket=> 0}
    OP_PUSH_PRIORY = {:add => 1, :sub => 1, :mult => 2, :div=> 2, :open_bracket=> 3}

    # Convert an infix tokenized expression to a postfix one
    #
    # @param tokens [Array<Number, Symbol>] a stream in infix
    # @return tokens [Array<Number, Symbol>] a stream in postfix
    def to_postfix(infix_expr)
      @op_stack = Array.new
      @context_stack = [@op_stack]
      @is_first = true

      @postfix_expr = Array.new
      infix_expr.each { |t| eval_token(t) }

      check_unclosed_bracket
      @postfix_expr + @op_stack.reverse
    end

    private
    def eval_token(token)
      hack_add_zero_to_support_unary_operation(token)
      if ExpressionTokenizer::OPERATOR_TOKEN.include? token
        eval_operator(token)
      elsif token.is_a? Numeric
        @postfix_expr.push(token)
      else
        raise StandardError.new "invalid token #{token}"
      end
    end

    private
    def eval_operator(operator)
      if operator == :open_bracket
        @is_first = true
        @op_stack = Array.new
        @context_stack.push(@op_stack)
      elsif operator == :close_bracket
        @postfix_expr += @context_stack.pop.reverse
        @op_stack = @context_stack.last
        check_context_stack_underflow
      else
        push_to_stack(operator)
      end
    end

    private
    def check_context_stack_underflow
      raise StandardError.new 'invalid expression: not found open bracket' \
        unless @context_stack.size > 0
    end

    private
    def check_unclosed_bracket
      raise StandardError.new 'invalid expression: unclosed bracket' \
        unless @context_stack.size == 1
    end

    private
    def push_to_stack(operator)
      @postfix_expr.push(@op_stack.pop) \
        while is_stacked_operator_lower_than? operator

      @op_stack.push(operator)
    end

    private
    def is_stacked_operator_lower_than?(op)
      !@op_stack.empty? and
        (OP_POP_PRIORY[@op_stack.last] >= OP_PUSH_PRIORY[op])
    end

    private
    def hack_add_zero_to_support_unary_operation(token)
      @postfix_expr.push(0) if @is_first and [:add, :sub].include? token
      @is_first = false
    end
  end
end
