RSpec.describe Blob do

  let(:sample_commit_content) {
<<-YAML
---
:tree: aaa
:parent: bbb
:message: test commit message
YAML
}

  before(:each) do
    clear_objects
  end

  context "Class Methods" do
    it "Blobs can be created" do
      instance = described_class.create(raw_content: "test content")
      expect(instance).to be_a Blob
    end

    it "can read an artifact" do
      instance = described_class.create(raw_content: "test content")
      expect(described_class.load(instance.sha)).to be_a Blob
    end
  end

  context "Instance Methods" do
    let(:persisted) { described_class.create(raw_content: "test content") }
    let(:instance) { described_class.load(persisted.sha) }

    it "the type of the class is the classname underscored" do
      expect(instance.type).to eq "blob"
    end

    it "persists the class with the raw content" do
      expect(instance.raw_content).to eq "test content"
    end
  end
end
