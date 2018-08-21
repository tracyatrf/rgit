class Adder
  def run(file_path)
    index = Index.load
    contents = File.read(file_path)
    sha = Artifact.create(type: :file, raw_content: contents).sha
    index.add_file({sha: sha, name: file_path})
    index.write
  end
end
