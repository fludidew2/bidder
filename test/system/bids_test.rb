require "application_system_test_case"

class BidsTest < ApplicationSystemTestCase
  setup do
    @bid = bids(:one)
  end

  test "visiting the index" do
    visit bids_url
    assert_selector "h1", text: "Bids"
  end

  test "should create bid" do
    visit bids_url
    click_on "New bid"

    fill_in "Amount", with: @bid.amount
    fill_in "Request", with: @bid.request_id
    fill_in "Status", with: @bid.status
    fill_in "Vendor", with: @bid.vendor_id
    click_on "Create Bid"

    assert_text "Bid was successfully created"
    click_on "Back"
  end

  test "should update Bid" do
    visit bid_url(@bid)
    click_on "Edit this bid", match: :first

    fill_in "Amount", with: @bid.amount
    fill_in "Request", with: @bid.request_id
    fill_in "Status", with: @bid.status
    fill_in "Vendor", with: @bid.vendor_id
    click_on "Update Bid"

    assert_text "Bid was successfully updated"
    click_on "Back"
  end

  test "should destroy Bid" do
    visit bid_url(@bid)
    click_on "Destroy this bid", match: :first

    assert_text "Bid was successfully destroyed"
  end
end
