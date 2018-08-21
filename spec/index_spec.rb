RSpec.describe Index do
  before do
    FileUtils.cp("spec/fixtures/index_sample.yml","spec/sandbox/index.yml")
  end

  it "can be created with a file" do
    expect(described_class.new).to be_a Index
  end

  context "load" do
    let(:subject) { described_class.load }

    it "can load a yaml file" do
      expect(subject.send(:files)).to be_a Array
    end

    context "after load" do
      let(:files) { subject.send(:files) }

      it "loads the correct file" do
        expect(files).to eq [
          { sha: "aaaaaaaa", name: "some_file" },
          { sha: "bbbbbbbb", name: "some_other_file" }
        ]
      end

      it "can have a file added and written" do
        subject.add_file({sha: "ccc", name: "added_file"})
        subject.write
        expect(YAML.load_file("#{RGIT_DIR}/index.yml")).to include({sha: "ccc", name: "added_file"})
      end
    end
  end
end
