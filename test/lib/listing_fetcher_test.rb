require 'test_helper'

class ListingFetcherTest < ActiveSupport::TestCase
  def parcel_url
    "http://assessor.co.grand.co.us/assessor/taxweb/account.jsp?accountNum=R107226"    
  end

  def test_it_finds_the_real_listing_page
    page = ListingFetcher.get_past_guest_login_button(parcel_url)
    assert_equal "Account", page.title
  end
  
  def test_it_parses_data_from_the_listing_page
    expected_values = {:land_type=>"Vacant Land",
      :actual_value=>55000,
      :assessed_value=>15950,
      :acreage=>0.7,
      :owner_name=>"HANICK, JOHN A & DIANE M",
      :owner_address=>"54 COUNTY ROAD 4103, GRANBY, CO 80446-9002"}
      
    assert_equal expected_values, ListingFetcher.fetch_parcel_data(parcel_url)
  end
  
  def test_fetching_nil_url_returns_blank_results
    assert_empty ListingFetcher.fetch_parcel_data(nil)
  end
end
