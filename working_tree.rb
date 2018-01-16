class WorkingTree
  attr_reader :filenames

  def initialize(filenames = files_from_working_directory)
    @filenames = filenames
  end

  def files_from_working_directory
    Dir['**/*'].reject {|fn| File.directory?(fn) }
  end

  def files
    @filenames.each_with_object({}) do |filename, memo|
      memo[filename] = File.read(filename)
    end
  end

  def hash_tree
    files.map do |filename, content|
      { sha: Util::Hasher.generate_sha(content), name: filename }
    end
  end
end


