RSpec.describe Commit do

  let(:sample_commit_content) {
<<-YAML
---
:tree: aaa
:parent: bbb
:message: test commit message
YAML
}

  let(:subject) { Commit }

  before(:each) do
    clear_objects
  end

  context "Class Methods" do
    it "Commits can be created" do
       instance = subject.create(tree: "aaa", parent: "bbb", message: "test commit message")
       expect(instance).to be_a Commit
    end

    it "can read an artifact" do
      instance = subject.create(tree: "aaa", parent: "bbb", message: "test commit message")
      expect(subject.load(instance.sha)).to be_a subject
    end
  end

  context "Instance Methods" do
    let(:persisted) { subject.create(tree: "aaa", parent: "bbb", message: "test commit message") }
    let(:instance) { subject.load(persisted.sha) }

    it "the type of the class is the classname underscored" do
      expect(instance.type).to eq "commit"
    end

    it "persists the class with the tree" do
      expect(instance.tree).to eq "aaa"
    end

    it "persists the class with the parent" do
      expect(instance.parent).to eq "bbb"
    end

    it "persists the class with the message" do
      expect(instance.message).to eq "test commit message"
    end

    it "maps to data to to yaml" do
      expect(instance.raw_content).to eq(sample_commit_content)
    end
  end
end
