require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  def test_it_exists
    assert Listing.new(
      :sequence_number => "001",
      :parcel_url => "http://example.com",
      :parcel_number => "001002",
      :tax_value => "1123",
      :active => true
    )
  end
    
  def test_it_pulls_deep_data
    listing = Listing.new(
      :sequence_number => "001",
      :parcel_url => "http://assessor.co.grand.co.us/assessor/taxweb/account.jsp?accountNum=R081085",
      :parcel_number => "001002",
      :tax_value => "1123",
      :active => true
    )
    listing.pull_deep_data
    assert listing.acreage >= 36
    assert_equal "Vacant Land", listing.land_type
    assert_equal 431500,  listing.actual_value
    assert_equal 125140, listing.assessed_value
    assert_equal "100 ACRE WOOD, LLC", listing.owner_name
    assert_equal "PO BOX 1825, WINTER PARK, CO 80482-1825", listing.owner_address
  end
end
