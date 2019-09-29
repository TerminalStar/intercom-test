require 'json'
require 'distance_calculator'
require 'json_file_reader'

class CustomerLocator
  include DistanceCalculator
  include JsonFileReader

  DEFAULT_FILE_PATH = "./bin/customers.txt"
  DEFAULT_DISTANCE_KM = 100

  attr_accessor :customer_file_path, :distance_within

  def initialize(file_path: DEFAULT_FILE_PATH, distance: DEFAULT_DISTANCE_KM)
    @customer_file_path = file_path
    @distance_within = distance
  end

  # Read file source from path @customer_file_path, find customers who are situated
  # within @distance_within and return array of these customers sorted by user ID.
  #
  # The returned array contains customer objects of the form { name: "string", id: user_id }
  def call
    customer_file = read_file(@customer_file_path)
    customer_json = JSON.parse(customer_file, symbolize_names: true)
    unsorted_customers = find_customers_within(@distance_within, customer_json)

    unsorted_customers
      .map { |customer| { name: customer[:name], id: customer[:user_id] } }
      .sort_by { |customer| customer[:id] }
  end

  private

  def find_customers_within(distance_km, customer_json)
    customer_json.select do |customer|
      longitude_rads = convert_to_radians(customer[:longitude].to_f)
      latitude_rads = convert_to_radians(customer[:latitude].to_f)

      distance_from_dublin = calculate_distance_between(longitude_rads, latitude_rads)

      distance_from_dublin <= distance_km
    end
  end
end
