require "json"
require 'pry'
require 'zlib'
require 'digest'
require 'pathname'
require 'yaml'
require 'fileutils'

RGIT_DIR = ENV["TEST_ENV"] ? "spec/sandbox" : ".rgit"

require 'active_support/core_ext/hash'
require 'awesome_print'
require 'active_support/core_ext/string'
require_relative 'lib/util/hasher'

require_relative 'lib/objects/artifact'
require_relative 'lib/objects/artifact_persistable'
require_relative 'lib/objects/object_factory'
require_relative 'lib/objects/blob'
require_relative 'lib/objects/tree'
require_relative 'lib/objects/commit'

require_relative 'head'
require_relative 'branch'
require_relative 'history'

require_relative 'working_tree'
require_relative 'tree_builder'
require_relative 'stage'
require_relative 'init'

require_relative 'index'

require_relative 'lib/commands/adder.rb'
require_relative 'lib/commands/committer.rb'
require_relative 'lib/commands/status.rb'
require_relative 'lib/commands/logger.rb'
