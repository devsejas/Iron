require "application_system_test_case"

class PurchaseOrdersTest < ApplicationSystemTestCase
  setup do
    @purchase_order = purchase_orders(:one)
  end

  test "visiting the index" do
    visit purchase_orders_url
    assert_selector "h1", text: "Purchase Orders"
  end

  test "creating a Purchase order" do
    visit purchase_orders_url
    click_on "New Purchase Order"

    fill_in "Currency", with: @purchase_order.currency_id
    fill_in "Date Order", with: @purchase_order.date_order
    fill_in "Name", with: @purchase_order.name
    fill_in "Note", with: @purchase_order.note
    fill_in "State", with: @purchase_order.state
    fill_in "Supplier", with: @purchase_order.supplier_id
    click_on "Create Purchase order"

    assert_text "Purchase order was successfully created"
    click_on "Back"
  end

  test "updating a Purchase order" do
    visit purchase_orders_url
    click_on "Edit", match: :first

    fill_in "Currency", with: @purchase_order.currency_id
    fill_in "Date Order", with: @purchase_order.date_order
    fill_in "Name", with: @purchase_order.name
    fill_in "Note", with: @purchase_order.note
    fill_in "State", with: @purchase_order.state
    fill_in "Supplier", with: @purchase_order.supplier_id
    click_on "Update Purchase order"

    assert_text "Purchase order was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase order" do
    visit purchase_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase order was successfully destroyed"
  end
end
