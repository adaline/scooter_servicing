require 'minitest/autorun'
require_relative '../lib/coup_service_packer'

class TestCoupServicePacker < Minitest::Test
  def setup
    @csp = CoupServicePacker.new([30, 10], 15, 5)
  end

  def min_district_fes_for(district_capacity, fm_capacity, answer)
    assert_equal answer, @csp.min_district_fe(district_capacity, fm_capacity)
  end

  def test_min_district_fes_range
    [
      # Scooters, FM capacity, FEs needed
      [10, 12, 0],
      [17, 12, 1],
      [25, 11, 3]
    ].each do |attrs|
      assert_equal attrs[2], @csp.min_district_fe(attrs[0], attrs[1])
    end
  end

  def test_district_oversubscription_range
    [
      # Scooters, FM capacity, leftover scooters
      [10, 1, 1],
      [15, 15, 0],
      [17, 10, 3]
    ].each do |attrs|
      assert_equal attrs[2], @csp.district_oversubscription(attrs[0], attrs[1])
    end
  end

  def test_lowest_fm_waste_index
    assert_equal [3, 0], @csp.lowest_fm_waste_index
  end

  def test_min_fe
    assert_equal 5, @csp.min_fes
  end
end
