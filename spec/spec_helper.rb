ENV["TEST_ENV"] = "true"
require_relative "../setup"

def clear_objects
  Pathname.new("#{RGIT_DIR}/objects").children.each { |p| p.rmtree }
end
