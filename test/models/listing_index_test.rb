require 'test_helper'

class ListingIndexTest < ActiveSupport::TestCase
  
  def expected
    {
      :page_count => 6,
      :count => 268,
      :last_record => {
        :sequence_number=>"000267", 
        :parcel_url=>"http://assessor.co.grand.co.us/assessor/taxweb/account.jsp?accountNum=M010480", 
        :parcel_number=>"M010480", 
        :tax_value=>104, 
        :active=>true
      }
    }  
  end
  
  def test_it_finds_the_page_count
    fetcher = ListingIndexFetcher.new
    assert_equal expected[:page_count], fetcher.page_count
  end

  def test_it_fetches_the_data
    fetcher = ListingIndexFetcher.new
    output = fetcher.fetch_all
    assert_equal expected[:count], output.count
    assert_equal expected[:last_record], output.last
  end
  
  def test_it_creates_records
    VCR.use_cassette("deep_listing_records") do
      fetcher = ListingIndexFetcher.new
      assert ListingIndex.all.empty?
      assert Listing.all.empty?
      
      index = fetcher.store_records
      
      assert expected[:count], index.records.count
      assert index.listings.find_by_sequence_number(expected[:last_record][:sequence_number])
    end
  end

end
