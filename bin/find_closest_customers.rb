$LOAD_PATH.unshift(File.expand_path(".", "lib"))
$LOAD_PATH.unshift(File.expand_path(".", "services"))

require 'customer_locator'

puts 'Finding customers...'

file_path = CustomerLocator::DEFAULT_FILE_PATH
distance = CustomerLocator::DEFAULT_DISTANCE_KM

file_arg_index = ARGV.find_index("--filepath")
distance_arg_index = ARGV.find_index("--distance")

unless file_arg_index.nil?
  file_path_value = file_arg_index + 1
  file_path = ARGV[file_path_value].to_s
end

unless distance_arg_index.nil?
  distance_value_index = distance_arg_index + 1
  distance = ARGV[distance_value_index].to_f
end

locator = CustomerLocator.new(file_path: file_path, distance: distance)
customers = locator.call

puts "Found #{customers.count} to invite!"
puts customers.join("\n")

output_file_name = "output.txt"

if File.exists?(output_file_name)
  puts "Output file #{output_file_name} already exists, overwriting..."
end

File.open(output_file_name, "w") do |f|
  f.write(customers)
end

puts "All done!"
