class Initializer
  class AlreadyInitializedError < StandardError; end

  def run
    already_init_error if storage_directory_exists?
    write_filetree
    true
  end

  def already_init_error
    raise AlreadyInitializedError "The storage directory already exists"
  end

  def write_filetree
    Dir.mkdir ".rgit"
    Dir.mkdir ".rgit/objects"
    Dir.mkdir ".rgit/refs"
  end

  def storage_directory_exists?
    directory_exists?('.rgit')
  end

  def directory_exists?(directory)
    File.directory?(directory)
  end
end

