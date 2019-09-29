require 'json_file_reader'
require 'json'

class DummyClass
  include JsonFileReader
end

RSpec.describe JsonFileReader, "#read_file" do
  let(:subject) { DummyClass.new }

  context "given file of expected format" do
    it "reads file and converts to valid JSON" do
      file_contents = subject.read_file("./spec/fixtures/files/example_customers.txt")
      expected_json = [
        { "latitude" => "54.133333", "user_id" => 24, "name" => "Rose Enright", "longitude" => "-6.433333" },
        { "latitude" => "55.033", "user_id" => 19, "name" => "Enid Cahill", "longitude" => "-8.112" },
        { "latitude" => "51.92893", "user_id" => 1, "name" => "Alice Cahill", "longitude" => "-10.27699" }
      ]

      expect(JSON.parse(file_contents)).to eq expected_json
    end
  end

  context "given malformed file" do
    it "throws an error parsing the malformed JSON" do
      file_contents = subject.read_file("./spec/fixtures/files/malformed_json.txt")

      expect { JSON.parse(file_contents) }.to raise_error(JSON::ParserError)
    end
  end

  context "given file that does not exist" do
    it "throws error loading file" do
      expect { subject.read_file("./not/a/real/file.txt") }.to raise_error(Errno::ENOENT)
    end
  end
end
