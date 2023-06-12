require "application_system_test_case"

class DocksTest < ApplicationSystemTestCase
  setup do
    @dock = docks(:one)
  end

  test "visiting the index" do
    visit docks_url
    assert_selector "h1", text: "Docks"
  end

  test "should create dock" do
    visit docks_url
    click_on "New dock"

    fill_in "Title", with: @dock.title
    fill_in "User", with: @dock.user_id
    click_on "Create Dock"

    assert_text "Dock was successfully created"
    click_on "Back"
  end

  test "should update Dock" do
    visit dock_url(@dock)
    click_on "Edit this dock", match: :first

    fill_in "Title", with: @dock.title
    fill_in "User", with: @dock.user_id
    click_on "Update Dock"

    assert_text "Dock was successfully updated"
    click_on "Back"
  end

  test "should destroy Dock" do
    visit dock_url(@dock)
    click_on "Destroy this dock", match: :first

    assert_text "Dock was successfully destroyed"
  end
end
