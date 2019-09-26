require 'customer_locator'

RSpec.describe CustomerLocator, "#list_customers" do
  context "given list of customers" do
    it "returns those within 100km" do
      locator = CustomerLocator.new
      correct_list = [{
        name: "Christina McArdle",
        id: 12
      }]

      # TODO: I don't think this kind of comparison actually works for arrays/arrays of objects
      expect(locator.list_customers).to eq correct_list
    end
  end
end
