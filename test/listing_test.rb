require 'minitest/autorun'
require 'minitest/pride'
require './lib/listing'

class ListingTest < Minitest::Test
	def test_it_exists
    assert Listing.new
  end
  
end

class ListingIndexTest < Minitest::Test
  def test_it_exists
    assert ListingIndex.new  
  end
  
  def test_it_fetches
    assert ListingIndex.new.fetch
  end
  
  def test_it_has_a_total_record_count
    index = ListingIndex.new
    index.fetch
    assert index.total_listings > 100
  end
end