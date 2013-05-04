require 'yaml'

config = YAML.load_file(ARGV[0])
system("ruby distcalc.rb eval -t add -p #{config['add']['port']} &")
system("ruby distcalc.rb eval -t sub -p #{config['sub']['port']} &")
system("ruby distcalc.rb eval -t mul -p #{config['mul']['port']} &")
system("ruby distcalc.rb eval -t div -p #{config['div']['port']} &")
system("ruby distcalc.rb server -p #{ARGV[1]} &")
