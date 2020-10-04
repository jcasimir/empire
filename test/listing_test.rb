require 'minitest/autorun'
require 'minitest/pride'
require './lib/listing'
require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end

class ListingTest < Minitest::Test
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
  
  def test_it_loads_all_deep_data
    VCR.use_cassette("all_deep_data") do
      index = ListingIndex.new
      index.fetch
      index.listings.each{|l| l.pull_deep_data}
      #binding.pry
    end
  end
end