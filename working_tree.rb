class WorkingTree
  def initialize
    @filenames = Dir['**/*'].reject {|fn| File.directory?(fn) }
  end

  def filenames
    @filenames
  end

  def files
    @filenames.each_with_object({}) do |filename, memo|
      memo[filename] = File.read(filename)
    end
  end
end


