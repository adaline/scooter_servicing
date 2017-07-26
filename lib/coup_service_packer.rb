class CoupServicePacker
  def initialize(scooters, c, p)
    @district_scooter_count = scooters
    @fleet_manager_capacity = c
    @fleet_engineer_capacity = p
  end

  def district_oversubscription(required_capacity, fm_capacity)
    # How many scooters left after FM is done?
    fm_oversubscription = required_capacity - fm_capacity
    return fm_oversubscription.abs if fm_oversubscription <= 0

    # How many scooters left after FEs are filled?
    (fm_oversubscription - (fm_oversubscription.to_f / @fleet_engineer_capacity).ceil * @fleet_engineer_capacity).abs
  end

  # Find minimum needed FEs to service a district
  def min_district_fe(required_capacity, fm_capacity)
    # How many scooters left after FM is done?
    fm_oversubscription = required_capacity - fm_capacity

    # (Whole) FEs needed to complete the work
    (fm_oversubscription.to_f / @fleet_engineer_capacity).ceil
  end

  # Find district for FM with lowest capcity waste
  def lowest_fm_waste_index
    waste_indexes = @district_scooter_count.each_with_index.map do |district_capacity, index|
      # Record wasted capacity and the index for each district
      [district_oversubscription(district_capacity, @fleet_manager_capacity), index]
    end
    # Sort and get the first optimal distrcit for FM
    distrcit_index = waste_indexes.sort { |a, b| a[0] <=> b[0] }.first[1]
    distrcit_fes = min_district_fe(@district_scooter_count[distrcit_index], @fleet_manager_capacity)

    [distrcit_fes, distrcit_index]
  end

  # Find the min needed FEs by finding the best district for FM and dividing the rest between FES
  def min_fes
    fm_district = lowest_fm_waste_index
    # Itterate over districts except FM's optimal
    left_over_districts = @district_scooter_count.each_with_index.reject {|_, index| index == fm_district[1]}.map { |v| v[0] }
    fe_counts = left_over_districts.map do |district_capacity|
      min_district_fe(district_capacity, 0)
    end
    # Combine FMs optimal FE count with rest
    fe_counts.inject(:+) + fm_district[0]
  end
end
