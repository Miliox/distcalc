require_relative './scanner'

module Calculator
  class InfixToPostfix
    OP_POP_PRIORY = {add: 1, sub: 1, mult: 2, div: 2, open_bracket: 0}
    OP_PUSH_PRIORY = {add: 1, sub: 1, mult: 2, div: 2, open_bracket: 3}

    # Convert a infix stream of tokens to postfix one
    #
    # @param tokens [Array<Number, Symbol>] a stream in infix
    # @return tokens [Array<Number, Symbol>] a stream in postfix
    def to_postfix(input_tokens)
      @output_tokens = Array.new
      @operators = Array.new

      input_tokens.each do |token|
        eval_token(token)
      end
      pop_until_empty

      @output_tokens
    end

    private
    def eval_token(token)
      if Scanner::OPERATORS_TOKENS.include? token
        eval_operator(token)
      elsif token.is_a? Numeric
        @output_tokens.push(token)
      else
        raise StandardError.new "invalid token #{token}"
      end
    end

    private
    def eval_operator(token)
      if token != :close_bracket
        push_operator(token)
      else
        pop_until_open_bracket
      end
    end

    private
    def push_operator(op)
      while is_stack_operator_lower? op do
        @output_tokens.push(@operators.pop)
      end

      @operators.push(op)
    end

    private
    def is_stack_operator_lower?(op)
      !@operators.empty? and (OP_POP_PRIORY[@operators.last] >= OP_PUSH_PRIORY[op])
    end

    private
    def pop_until_open_bracket
      until @operators.last == :open_bracket
        if @operators.empty?
          raise StandardError.new 'invalid expression: not found open bracket'
        end
        @output_tokens.push(@operators.pop)
      end
      @operators.pop
    end

    private
    def pop_until_empty
      until @operators.empty?
        if @operators.last != :open_bracket
          @output_tokens.push(@operators.pop)
        else
          raise StandardError.new 'invalid expression: unclosed bracket'
        end
      end
    end
  end
end
