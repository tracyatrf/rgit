module ObjectFactory
  def self.load(sha)
    data = Artifact.read(sha)
    klass = snake_to_const(data[:type])
    klass.new(**klass.extract_data(data[:raw_content]), sha: sha)
  end

  def self.snake_to_const(str)
    str.camelize.constantize
  end
end
