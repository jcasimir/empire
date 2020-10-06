require 'test_helper'

class ListingIndexTest < ActiveSupport::TestCase
  def test_it_fetches
    assert ListingIndex.new.fetch
  end

  def test_it_has_a_total_record_count
    index = ListingIndex.new
    index.fetch
    assert index.listings.size > 10
  end
      
  def test_it_makes_listings
    index = ListingIndex.new
    index.fetch
    assert index.listings.size > 0
    assert index.listings.first
  end
    
  def test_it_loads_all_deep_data
    VCR.use_cassette("all_deep_data") do
      index = ListingIndex.new
      index.fetch
      index.listings.each{|l| l.pull_deep_data}
    end
  end
end

  
