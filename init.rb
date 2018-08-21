class Initializer
  class AlreadyInitializedError < StandardError; end

  def run
    already_init_error if storage_directory_exists?
    write_storage_directory
    true
  end

  def already_init_error
    raise AlreadyInitializedError "The storage directory already exists"
  end

  def write_storage_directory
    Dir.mkdir RGIT_DIR
    Dir.mkdir "#{RGIT_DIR}/objects"
    Dir.mkdir "#{RGIT_DIR}/refs"
    FileUtils.cp("templates/index.yml","#{RGIT_DIR}/index.yml")
    File.open("#{RGIT_DIR}/HEAD", "w") { |file| file.write("master") }
  end

  def storage_directory_exists?
    directory_exists?(RGIT_DIR)
  end

  def directory_exists?(directory)
    File.directory?(directory)
  end
end
