# encoding: UTF-8
require_relative './network'

class Client
  include Network::Client

  def calculate(expr)
    puts send(expr)
  end

  def start
    while(true)
      puts 'Provide a math expression:'
      puts 'The result is: ', send(gets)
    end
  end
end
