RSpec.describe ArtifactPersistable do
  class TestClass
    include(ArtifactPersistable)

    attr_reader :raw_content

    def self.extract_data(file_contents)
      { raw_content: file_contents }
    end

    def initialize(sha: nil, raw_content: nil)
      @raw_content = raw_content
      @sha = sha
    end
  end

  let(:klass) { TestClass }
  let(:instance) { klass.new(raw_content: "some_content").persist }

  before(:each) do
    clear_objects
  end

  context "Class Methods" do
    it "can be created and includes proper methods" do
      expect([:load, :extract_data, :read_artifact] - klass.methods).to be_empty
    end

    it "can read an artifact" do
      expect(klass.load(instance.sha)).to be_a klass
    end
  end

  context "Instance Methods" do
    it "the type of the class is the classname underscored" do
      expect(instance.type).to eq "test_class"
    end

    it "persists the class with the raw content" do
      expect(klass.load(instance.sha).raw_content).to eq "some_content"
    end
  end
end
