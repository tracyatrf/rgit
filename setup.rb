require "json"
require 'pry'
require 'zlib'
require 'digest'
require 'pathname'
require 'yaml'
require 'fileutils'

RGIT_DIR = ENV["TEST_ENV"] ? "spec/sandbox" : ".rgit"

require_relative 'util/hasher'
require_relative 'index'
require_relative 'artifact'
require_relative 'artifact_persistable'

require_relative 'blob'
require_relative 'working_tree'
require_relative 'stage'
require_relative 'init'

require_relative 'commands/adder.rb'
require_relative 'commands/committer.rb'
require_relative 'commands/status.rb'
