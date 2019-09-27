require 'json'

class CustomerLocator
  DUBLIN_OFFICE_LATITUDE = 53.339428.freeze
  DUBLIN_OFFICE_LONGITUDE = -6.257664.freeze
  MEAN_EARTH_RADIUS_KM = 6371.freeze
  DISTANCE_WITHIN_KM = 100

    # 1. Read customers file
    #   1a. Parse as JSON
    #   NB parse floats (coordinates) correctly!!!
    # 2. do formula for each customer?
    # 3. choose those within 100km
    # 4. output name + user id, in user id order

  def list_customers
    customer_file = read_file
    customer_json = JSON.parse(customer_file, symbolize_names: true)
    closest_customers = find_customers_within(DISTANCE_WITHIN_KM, customer_json)

    closest_customers.map { |c| { name: c[:name], id: c[:user_id] } }.sort_by { |c| c[:id] }
  end

  private

  def dublin_longitude_rads
    @dublin_longitude_rads ||= convert_to_rads(DUBLIN_OFFICE_LONGITUDE)
  end

  def dublin_latitude_rads
    @dublin_latitude_rads ||= convert_to_rads(DUBLIN_OFFICE_LATITUDE)
  end

  # TODO: maybe a service?
  # TODO: maybe we should assume we're given floats? & throw sensible error when not
  #   -> then we can test this error is thrownnnn
  def convert_to_rads(degrees)
    (degrees.to_f * Math::PI) / 180
  end

  # TODO: file name as param / ENV / const
  # TODO: maybe split out the json fixing?
  def read_file
    File
      .read("customers.txt")
      .gsub("\n", ",")
      .prepend("[") << "]"
  end

  # TODO: test this throws error when distance_km is not a number/float
  def find_customers_within(distance_km, customer_json)
    customer_json.select do |customer|
      longitude_rads = convert_to_rads(customer[:longitude])
      latitude_rads = convert_to_rads(customer[:latitude])

      distance_from_dublin = calculate_distance(longitude_rads, latitude_rads)

      distance_from_dublin <= distance_km
    end
  end

  def calculate_distance(customer_longitude_rads, customer_latitude_rads)
    cos_delta = Math.cos((dublin_longitude_rads - customer_longitude_rads).abs)
    sub_formula = (Math.sin(dublin_latitude_rads) * Math.sin(customer_latitude_rads)) + (Math.cos(dublin_latitude_rads) * Math.cos(customer_latitude_rads) * cos_delta)
    angle_between = Math.acos(sub_formula)

    angle_between * MEAN_EARTH_RADIUS_KM
  end
end
