Bundler.require
require 'minitest/autorun'
require 'minitest/pride'
require './lib/listing_index'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
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