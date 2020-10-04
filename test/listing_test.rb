require 'minitest/autorun'
require 'minitest/pride'
require './lib/listing'

class ListingTest < Minitest::Test
	def test_it_exists
    assert Listing.new(
      :sequence_number => "001",
      :parcel_url => "http://example.com",
      :parcel_number => "001002",
      :value => "$1,123",
      :active => true
    )
  end
  
end

class ListingIndexTest < Minitest::Test
  def test_it_fetches
    assert ListingIndex.new.fetch
  end
  
  def test_it_has_a_total_record_count
    index = ListingIndex.new
    index.fetch
    assert index.total_listings > 100
  end
  
  def test_it_makes_listings
    index = ListingIndex.new
    index.fetch
    assert index.count > 0
    assert index.first
  end
end