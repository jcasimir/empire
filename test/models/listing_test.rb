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
end
