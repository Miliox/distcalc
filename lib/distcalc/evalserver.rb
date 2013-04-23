require 'socket'

class EvalServer
  def initialize(operator="add", port=2000)
    @server = TCPServer.new port # Server bound to port 2000
    @operator = operator
  end

  def start
    
    loop {                          # Servers run forever
      Thread.start(@server.accept) do |client|
        request = client.gets
              expr = self.parseRequest(request) #definir formato da request
              client.puts self.calculate(expr)
        client.close                # Disconnect from the client
      end
    }
    
  end

  def parseRequest(request)
    return {
      "operador1" => 409,
      "operador2" => 700
    }
  end

  def calculate(expr)
    if(@operator == "add")
      return expr["operador1"] + expr["operador2"]
    end
    if(@operator == "sub")
      return expr["operador1"] - expr["operador2"]
    end
    if(@operator == "div")
      return expr["operador1"] / expr["operador2"] # esta truncando o valor !!!
    end
    if(@operator == "mul")
      return expr["operador1"] * expr["operador2"]
    end
  end

end

evalServer = EvalServer.new #ARGV[0], ARGV[1]  
evalServer.start()

