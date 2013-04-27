# encoding: utf-8
module Calculator
  class BinaryOperation
    def eval(arg1, arg2)
      raise NotImplementedError.new 'Not supported operation'
    end
  end

  class Addition < BinaryOperation
    def eval(arg1, arg2)
      arg1 + arg2
    end
  end

  class Subtraction < BinaryOperation
    def eval(arg1, arg2)
      arg1 - arg2
    end
  end

  class Multiplication < BinaryOperation
    def eval(arg1, arg2)
      arg1 * arg2
    end
  end

  class Division < BinaryOperation
    def eval(arg1, arg2)
      arg1 / arg2
    end
  end
end
