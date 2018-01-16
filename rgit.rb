#/bin/ruby
require_relative "setup"

command = ARGV[0].to_sym
arguments = ARGV[1..-1]


command_map = {
  init: Initializer,
  add: Adder,
  status: Status,
  commit: Committer
}
raise "Invalid Command" unless command_map.keys.include? command
command_map[command].new.run(*arguments)
