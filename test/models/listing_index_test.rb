require 'test_helper'

class ListingIndexTest < ActiveSupport::TestCase

  def test_it_finds_the_page_count
    index = ListingIndex.new
    index.fetch
    assert_equal 6, index.page_count
  end
  
  def test_it_parses_all_pages
    index = ListingIndex.new
    index.fetch
    quantity = index.parse
    assert quantity > 250
  end
end

# def test_it_has_a_total_record_count
#   index = ListingIndex.new
#   index.fetch
#   assert index.listings.size > 10
# end
#     
# def test_it_makes_listings
#   index = ListingIndex.new
#   index.fetch
#   assert index.listings.size > 0
#   assert index.listings.first
# end
#   
# def test_it_loads_all_deep_data
#   VCR.use_cassette("all_deep_data") do
#     index = ListingIndex.new
#     index.fetch
#     index.listings.each{|l| l.pull_deep_data}
#   end
# end
# 
# def test_it_loads_a_second_page
#   index = ListingIndex.new
#   assert_equal 0, index.listings.size 
#   index.fetch(2)
#   assert index.listings.size > 75
# end
#   
