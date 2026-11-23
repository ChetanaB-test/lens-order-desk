require "application_system_test_case"

class OrderJourneyTest < ApplicationSystemTestCase
  test "operator enters a retail order and views its documents" do
    visit root_path
    assert_text "No orders yet."
    click_link "New order"
    fill_in "Customer name", with: "Mira Sample"
    fill_in "Email", with: "mira@example.test"
    select "Contact lens trial pack · €12.90", from: "Product"
    fill_in "Quantity", with: 3
    click_button "Create order"
    assert_text "Order received."
    assert_text "€38.70"
    assert_no_link "View sample invoice"

    click_button "Mark as packed"
    click_link "View delivery note"
    assert_selector "h1", text: "Delivery note"
    assert_text "Mira Sample"
    assert_no_text "€38.70"

    click_link "Back to order"
    click_button "Mark as dispatched"
    click_button "Mark as invoiced"
    click_link "View sample invoice"
    assert_selector "h1", text: "Sample invoice"
    assert_text "€38.70"

    click_link "Lens Order Desk"
    assert_text "Invoiced"
    assert_text "Mira Sample"
  end

  test "narrow form and printed delivery note show the expected information" do
    page.current_window.resize_to(375, 820)
    visit new_order_path
    assert_selector "label[for=order_customer]", text: "Customer name"
    assert_selector "label[for=order_email]", text: "Email"
    assert page.evaluate_script("document.documentElement.scrollWidth <= window.innerWidth"),
      "Order form should fit the viewport"

    fill_in "Customer name", with: "Élan & Fils"
    fill_in "Email", with: "elan@example.test"
    select "Trade (B2B)", from: "Channel"
    select "Single-vision lens sample · €24.50", from: "Product"
    fill_in "Quantity", with: 100
    click_button "Create order"
    assert_text "€2,450.00"
    click_button "Mark as packed"
    click_link "View delivery note"

    browser = page.driver.browser


    # Apply print styles so we can check what appears on the delivery note without opening the print dialog.
    browser.execute_cdp("Emulation.setEmulatedMedia", media: "print")
    begin
      assert_selector "h1", text: "Delivery note"
      assert_text "Élan & Fils"
      assert_no_selector "nav"
      assert_no_link "Back to order"
    ensure
      browser.execute_cdp("Emulation.setEmulatedMedia", media: "")
      page.current_window.resize_to(1280, 900)
    end
  end
end
