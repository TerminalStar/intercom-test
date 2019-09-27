require 'customer_locator'

RSpec.describe CustomerLocator, "#list_customers" do
  let(:locator) { CustomerLocator.new }

  context "given list of customers" do
    it "returns all customers when everyone within 100km" do
      correct_list = [{
        latitude: "52.986375",
        user_id: 12,
        name: "Christina McArdle",
        longitude: "-6.043701"
      }, {
        latitude: "53.008769",
        user_id: 11,
        name: "Richard Finnegan",
        longitude: "-6.1056711"
      }]

      expect(locator.list_customers("./spec/fixtures/files/all_customers_within_100km.txt")).to eq correct_list
    end

    it "returns nothing when no one is within 100km" do
      empty_list = []

      expect(locator.list_customers("./spec/fixtures/files/no_customers_within_100km.txt")).to eq empty_list
    end

    it "returns only customers within 100km" do
      correct_list = [{
        latitude: "54.133333",
        user_id: 24,
        name: "Rose Enright",
        longitude: "-6.433333"
      }]

      expect(locator.list_customers("./spec/fixtures/files/some_customers_within_100km.txt")).to eq correct_list
    end
  end

  context "file doesn't exist" do
    it "throws error loading file" do
      expect { locator.list_customers("./not/a/real/file.txt") }.to raise_error(Errno::ENOENT)
    end
  end
end
