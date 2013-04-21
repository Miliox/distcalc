distcalc
========

Distributed Ruby Calculator
=======
# Distcalc

A simple distributed calculator for basic arithmetic.
Resolve simple math expression of +,-,\*,/ with () to enforce
precedence.


## Installation

Add this line to your application's Gemfile:

    gem 'distcalc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install distcalc

## Usage

Simple usage:

    $ distcalc
      usage: distcalc calc [--verbose] [-s[=<uri|ip>]] [<math_expr>]
         or: distcalc eval-server [--verbose] -t[=<add|sub|mul|div>] [--port=[=<port>]]
         or: distcalc calc-server [--verbose] [-p[=<port>]] <config-file>
         or: distcalc --version

      when math_expr is not passed, it reads from stdin
      when -s|--server is not passed, it uses localhost
      when -p|--port of eval-server is not passed, it uses 3741
      when -p|--port of calc-server is not passed, it uses 6416
      when config-file is not passed, it reads from stdin

      config-file is a YAML file using the following structure:
      ----------
      add: { server: <URL>, port: <PORT>}
      sub: { server: <URL>, port: <PORT>}
      mul: { server: <URL>, port: <PORT>}
      div: { server: <URL>, port: <PORT>}
      ----------

      use --verbose to Debug and Trace Operations

Simple Expression :

    $ distcalc --server=mycalc.server.com:1234 5 + 3 * 2 + (3 - 5)
      9

or from a file to a file:

    $ echo 1 + 2 + 3 + 4 + 5 > math.txt
    $ distcalc < math_expr.txt > math_result.txt
    $ cat math_result.txt
      15

Create calc server:

    $ distcalc calc-server -p 8080 < eval_servers.yaml

Create an operator server:

    $ distcalc eval-server -t add -p 54321

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
