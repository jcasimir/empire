require "application_system_test_case"

class ListingIndicesTest < ApplicationSystemTestCase
  setup do
    @listing_index = listing_indices(:one)
  end

  test "visiting the index" do
    visit listing_indices_url
    assert_selector "h1", text: "Listing Indices"
  end

  test "creating a Listing index" do
    visit listing_indices_url
    click_on "New Listing Index"

    fill_in "Source document", with: @listing_index.source_document
    click_on "Create Listing index"

    assert_text "Listing index was successfully created"
    click_on "Back"
  end

  test "updating a Listing index" do
    visit listing_indices_url
    click_on "Edit", match: :first

    fill_in "Source document", with: @listing_index.source_document
    click_on "Update Listing index"

    assert_text "Listing index was successfully updated"
    click_on "Back"
  end

  test "destroying a Listing index" do
    visit listing_indices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Listing index was successfully destroyed"
  end
end
