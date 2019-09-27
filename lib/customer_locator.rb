require 'json'
require './services/distance_calculator'

class CustomerLocator
  include DistanceCalculator

  DEFAULT_FILE_PATH = "./bin/customers.txt"
  DISTANCE_WITHIN_KM = 100

  # TODO: changeable distance?
  # TODO: this should be call?
  def list_customers(file_path = DEFAULT_FILE_PATH)
    customer_file = read_file(file_path)
    customer_json = JSON.parse(customer_file, symbolize_names: true)
    find_customers_within(DISTANCE_WITHIN_KM, customer_json)
  end

  private

  # TODO: file name as param / ENV / const
  # TODO: maybe split out the json fixing?
  def read_file(file)
    File
      .read(file)
      .gsub("}\n{", "},{")
      .prepend("[") << "]"
  end

  # TODO: test this throws error when distance_km is not a number/float
  def find_customers_within(distance_km, customer_json)
    customer_json.select do |customer|
      longitude_rads = convert_to_radians(customer[:longitude].to_f)
      latitude_rads = convert_to_radians(customer[:latitude].to_f)

      distance_from_dublin = calculate_distance_between(longitude_rads, latitude_rads)

      distance_from_dublin <= distance_km
    end
  end
end
