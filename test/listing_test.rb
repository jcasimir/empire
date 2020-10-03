require 'minitest/autorun'
require 'minitest/pride'
require './lib/listing'

class ListingTest < Minitest::Test
	def test_it_exists
    assert Listing.new
  end
end