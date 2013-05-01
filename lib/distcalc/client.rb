# encoding: UTF-8
require './network'

class Client
  include Network::Client
  
  def calculate(expr)
    puts 'The result is: ', send(gets)
  end
  
  def start
    while(true)
      puts 'Provide a math expression:'
      puts 'The result is: ', send(gets)
    end
  end
end

client = Client.new
client.start() 







   