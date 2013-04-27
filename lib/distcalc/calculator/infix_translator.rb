require_relative './expression_tokenizer'

module Calculator
  class InfixTranslator
    OP_POP_PRIORY = {add: 1, sub: 1, mult: 2, div: 2, open_bracket: 0}
    OP_PUSH_PRIORY = {add: 1, sub: 1, mult: 2, div: 2, open_bracket: 3}

    # Convert an infix tokenized expression to a postfix one
    #
    # @param tokens [Array<Number, Symbol>] a stream in infix
    # @return tokens [Array<Number, Symbol>] a stream in postfix
    def to_postfix(infix_expression)
      @postfix_expression = Array.new
      @operator_stack = Array.new

      infix_expression.each { |t| eval_token(t) }

      raise \
        StandardError.new 'invalid expression: unclosed bracket' \
        if @operator_stack.include? :open_bracket

      @postfix_expression + @operator_stack.reverse
    end

    private
    def eval_token(token)
      if ExpressionTokenizer::OPERATOR_TOKEN.include? token
        eval_operator(token)
      elsif token.is_a? Numeric
        @postfix_expression.push(token)
      else
        raise StandardError.new "invalid token #{token}"
      end
    end

    private
    def eval_operator(operator)
      if operator != :close_bracket
        push_to_stack(operator)
      else
        pop_stack_until_open_bracket
      end
    end

    private
    def push_to_stack(operator)
      while is_stacked_operator_lower_than? operator do
        @postfix_expression.push(@operator_stack.pop)
      end

      @operator_stack.push(operator)
    end

    private
    def is_stacked_operator_lower_than?(op)
      !@operator_stack.empty? and
        (OP_POP_PRIORY[@operator_stack.last] >= OP_PUSH_PRIORY[op])
    end

    private
    def pop_stack_until_open_bracket
      until @operator_stack.last == :open_bracket
        if @operator_stack.empty?
          raise StandardError.new 'invalid expression: not found open bracket'
        end
        @postfix_expression.push(@operator_stack.pop)
      end
      @operator_stack.pop
    end
  end
end
