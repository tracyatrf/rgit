require "json"
require 'pry'
require 'zlib'
require 'digest'
require 'pathname'
require 'yaml'

require_relative 'artifact'
require_relative 'artifact_persistable'

require_relative 'blob'
require_relative 'working_tree'
require_relative 'stage'
require_relative 'init'
RGIT_DIR = ENV["TEST_ENV"] ? "spec/sandbox" : ".rgit"

