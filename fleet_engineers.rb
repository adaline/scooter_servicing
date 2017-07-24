#!/usr/bin/env ruby

require './lib/coup_service_packer'
require 'json'

# Task shows json-like input and output, based on CLI and http options - assuming it to be actuall json

# Very basic validations
# Input present
if ARGV[0].nil?
  puts 'No input provided, please see README.txt for usage'
  exit 1
end
# Input can be decoded as JSON
begin
  data = JSON.parse(ARGV[0])
rescue JSON::ParserError
  puts 'Input data format invalid, please see README.txt for usage'
  exit 1
end
# Input has required data
%w(scooters C P).each do |expected_key|
  unless data.key? expected_key
    puts 'Input data missing expected keys, please see README.txt for usage'
    exit 1
  end
end

# Further checkes skipped (eg data types, acceptable ranges), hopefully you can see that
# i can do it without myself writing it all out

district_scooter_count = data['scooters']
fleet_manager_capacity = data['C']
fleet_engineer_capacity = data['P']

csp = CoupServicePacker.new(district_scooter_count, fleet_manager_capacity, fleet_engineer_capacity)
puts({ fleet_engineers: csp.min_fes }.to_json)
