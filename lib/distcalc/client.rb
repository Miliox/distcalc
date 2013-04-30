# encoding: UTF-8
require 'socket'

class Client
  
  def initialize(host = 'localhost', port = 2000)
    @host = host
    @port = port
  end
  
  def start
    while(true)
      puts 'Provide a math expression:'
      send_math_expr(gets)
    end
  end
  
  def send_math_expr(input)
    connect()
    @server.puts input
    while line = @server.gets
      puts "The result: ", line
    end
    @server.close()
  end
  
  def connect
    @server = TCPSocket.new @host, @port
  end
end

client = Client.new
client.start() 







   