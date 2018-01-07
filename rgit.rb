require_relative "setup"

command = ARGV[0].to_sym
arguments = ARGV[1..-1]

valid_commands = [:init]
raise "Invalid Command" unless valid_commands.include? command

command_map = {
  init: Initializer
}
command_map[command].new.run(*arguments)
