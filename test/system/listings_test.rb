require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    @listing = listings(:one)
  end

  test "visiting the index" do
    visit listings_url
    assert_selector "h1", text: "Listings"
  end

  test "creating a Listing" do
    visit listings_url
    click_on "New Listing"

    fill_in "Acreage", with: @listing.acreage
    check "Active" if @listing.active
    fill_in "Actual value", with: @listing.actual_value
    fill_in "Assessed value", with: @listing.assessed_value
    fill_in "Land type", with: @listing.land_type
    fill_in "Owner address", with: @listing.owner_address
    fill_in "Owner name", with: @listing.owner_name
    fill_in "Parcel url", with: @listing.parcel_url
    fill_in "Sequence number", with: @listing.sequence_number
    fill_in "Tax value", with: @listing.tax_value
    click_on "Create Listing"

    assert_text "Listing was successfully created"
    click_on "Back"
  end

  test "updating a Listing" do
    visit listings_url
    click_on "Edit", match: :first

    fill_in "Acreage", with: @listing.acreage
    check "Active" if @listing.active
    fill_in "Actual value", with: @listing.actual_value
    fill_in "Assessed value", with: @listing.assessed_value
    fill_in "Land type", with: @listing.land_type
    fill_in "Owner address", with: @listing.owner_address
    fill_in "Owner name", with: @listing.owner_name
    fill_in "Parcel url", with: @listing.parcel_url
    fill_in "Sequence number", with: @listing.sequence_number
    fill_in "Tax value", with: @listing.tax_value
    click_on "Update Listing"

    assert_text "Listing was successfully updated"
    click_on "Back"
  end

  test "destroying a Listing" do
    visit listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Listing was successfully destroyed"
  end
end
