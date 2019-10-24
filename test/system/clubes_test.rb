require "application_system_test_case"

class ClubesTest < ApplicationSystemTestCase
  setup do
    @clube = clubes(:one)
  end

  test "visiting the index" do
    visit clubes_url
    assert_selector "h1", text: "Clubes"
  end

  test "creating a Clube" do
    visit clubes_url
    click_on "New Clube"

    click_on "Create Clube"

    assert_text "Clube was successfully created"
    click_on "Back"
  end

  test "updating a Clube" do
    visit clubes_url
    click_on "Edit", match: :first

    click_on "Update Clube"

    assert_text "Clube was successfully updated"
    click_on "Back"
  end

  test "destroying a Clube" do
    visit clubes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Clube was successfully destroyed"
  end
end
