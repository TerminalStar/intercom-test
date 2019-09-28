require 'customer_locator'

RSpec.describe CustomerLocator, "#call" do
  let(:locator) { CustomerLocator.new }

  def compare_response(test_data, correct_list)
    allow(locator).to receive(:read_file).and_return(test_data)
    expect(locator.call).to eq correct_list
  end

  context "given list of customers" do
    it "returns all customers when everyone within 100km" do
      test_data = "[{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"},{\"latitude\": \"53.008769\", \"user_id\": 11, \"name\": \"Richard Finnegan\", \"longitude\": \"-6.1056711\"}]"
      correct_list = [{
        id: 11,
        name: "Richard Finnegan"
      }, {
        id: 12,
        name: "Christina McArdle"
      }]

      compare_response(test_data, correct_list)
    end

    it "returns nothing when no one is within 100km" do
      test_data = "[{\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"},{\"latitude\": \"52.833502\", \"user_id\": 25, \"name\": \"David Behan\", \"longitude\": \"-8.522366\"}]"
      empty_list = []

      compare_response(test_data, empty_list)
    end

    it "returns only customers within 100km" do
      test_data = "[{\"latitude\": \"54.133333\", \"user_id\": 24, \"name\": \"Rose Enright\", \"longitude\": \"-6.433333\"},{\"latitude\": \"55.033\", \"user_id\": 19, \"name\": \"Enid Cahill\", \"longitude\": \"-8.112\"},{\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}]"
      correct_list = [{
        id: 24,
        name: "Rose Enright"
      }]

      compare_response(test_data, correct_list)
    end
  end

  context "given invalid params" do
    context "given invalid distance value" do
      it "throws error when distance is string" do
        locator = CustomerLocator.new(
          distance: 'not really a distance'
        )

        allow(locator).to receive(:read_file).and_return("[{}]")
        expect { locator.call }.to raise_error(ArgumentError)
      end

      it "throws error when distance is nil" do
        locator = CustomerLocator.new(
          distance: nil
        )

        allow(locator).to receive(:read_file).and_return("[{}]")
        expect { locator.call }.to raise_error(ArgumentError)
      end
    end
  end
end
