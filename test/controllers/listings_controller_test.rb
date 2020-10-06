require 'test_helper'

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = Listing.create()
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    assert_difference('Listing.count') do
      post listings_url, params: { listing: { acreage: @listing.acreage, active: @listing.active, actual_value: @listing.actual_value, assessed_value: @listing.assessed_value, land_type: @listing.land_type, owner_address: @listing.owner_address, owner_name: @listing.owner_name, parcel_url: @listing.parcel_url, sequence_number: @listing.sequence_number, tax_value: @listing.tax_value } }
    end

    assert_redirected_to listing_url(Listing.last)
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    patch listing_url(@listing), params: { listing: { acreage: @listing.acreage, active: @listing.active, actual_value: @listing.actual_value, assessed_value: @listing.assessed_value, land_type: @listing.land_type, owner_address: @listing.owner_address, owner_name: @listing.owner_name, parcel_url: @listing.parcel_url, sequence_number: @listing.sequence_number, tax_value: @listing.tax_value } }
    assert_redirected_to listing_url(@listing)
  end

  test "should destroy listing" do
    assert_difference('Listing.count', -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end
end
