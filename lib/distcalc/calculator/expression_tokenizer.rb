module Calculator
  class ExpressionTokenizer
    OPERATOR_TOKEN = [:add, :sub, :mult, :div] +
                     [:open_bracket, :close_bracket]
    OPERATORS_CHAR = [?+, ?-, ?*, ?/, ?(, ?)]

    WHITE_SPACES = [?\ , ?\r, ?\n, ?\v]

    OPERATOR_MAP = {?+ => :add,
                    ?- => :sub,
                    ?* => :mult,
                    ?/ => :div,
                    ?( => :open_bracket,
                    ?) => :close_bracket}

    # Scan a math expression into a stream of tokens
    # tokens are of two types: integers or symbols
    # (:add,:sub,:mult,:div,:open_brackets, :close_brackets)
    #
    # @param math_expr [String] the math expression
    # @return [Array<Number, Symbol>] a stream of tokens
    # @raise [ScannerError] If found an illegal character in expression
    def tokenize(math_expr)
      @num_tokens = Array.new
      @tokens = Array.new

      pos = 0
      math_expr.each_char do |c|
        eval_char(c, pos)
        pos += 1
      end
      push_number

      @tokens
    end

    private
    def eval_char(c, pos)
        if OPERATORS_CHAR.include? c
          push_number
          @tokens.push(OPERATOR_MAP[c])
        elsif (?0..?9).include? c
          @num_tokens.push(c)
        elsif WHITE_SPACES.include? c
          push_number
        else
          raise ScannerError.new "invalid token #{c} at #{pos}"
        end
    end

    private
    def push_number
      unless @num_tokens.empty?
        @tokens.push(@num_tokens.join.to_i)
        @num_tokens.clear
      end
    end
  end

  class ScannerError < StandardError
  end

end
