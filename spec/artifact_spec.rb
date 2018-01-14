RSpec.describe Artifact do
  before(:each) do
    clear_objects
  end

  context "with valid information" do
    let(:type) { :blob }
    let(:raw_content) { "hello world" }

    it "can be created" do
      expect(Artifact.new(type: type, raw_content: raw_content)).to be_a Artifact
    end

    context "properly created" do
      let(:artifact) { Artifact.create(type: type, raw_content: raw_content) }

      it "has a proper sha" do
        #this is dependent on raw content equalling "hello world"
        expect(artifact.sha).to eq "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed"
      end

      it "creates a file with the correct filename" do
        expect(Pathname.new("#{RGIT_DIR}/objects/#{artifact.sha}")).to exist
      end
      
      it "creates a file with the correct content" do
        expect(File.read("#{RGIT_DIR}/objects/#{artifact.sha}")).to eq "hello world"
      end
    end
  end
end
