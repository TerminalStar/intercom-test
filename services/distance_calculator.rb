module DistanceCalculator
  DUBLIN_OFFICE_LATITUDE = 53.339428.freeze
  DUBLIN_OFFICE_LONGITUDE = -6.257664.freeze
  MEAN_EARTH_RADIUS_KM = 6371.freeze

  # TODO: maybe we should assume we're given floats? & throw sensible error when not
  #   -> then we can test this error is thrownnnn
  def convert_to_radians(degrees)
    ((degrees * Math::PI) / 180).round(6)
  end

  def calculate_distance_between(customer_longitude_rads, customer_latitude_rads)
    cos_delta = Math.cos((dublin_longitude_rads - customer_longitude_rads).abs)
    sub_formula = (Math.sin(dublin_latitude_rads) * Math.sin(customer_latitude_rads)) + (Math.cos(dublin_latitude_rads) * Math.cos(customer_latitude_rads) * cos_delta)
    angle_between = Math.acos(sub_formula)

    (angle_between * MEAN_EARTH_RADIUS_KM).round(6)
  end

  private

  def dublin_longitude_rads
    @dublin_longitude_rads ||= convert_to_radians(DUBLIN_OFFICE_LONGITUDE)
  end

  def dublin_latitude_rads
    @dublin_latitude_rads ||= convert_to_radians(DUBLIN_OFFICE_LATITUDE)
  end
end
