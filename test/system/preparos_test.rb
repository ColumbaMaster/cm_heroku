require "application_system_test_case"

class PreparosTest < ApplicationSystemTestCase
  setup do
    @preparo = preparos(:one)
  end

  test "visiting the index" do
    visit preparos_url
    assert_selector "h1", text: "Preparos"
  end

  test "creating a Preparo" do
    visit preparos_url
    click_on "New Preparo"

    fill_in "Descricao", with: @preparo.descricao
    fill_in "Nome", with: @preparo.nome
    fill_in "Tipo prova", with: @preparo.tipo_prova
    click_on "Create Preparo"

    assert_text "Preparo was successfully created"
    click_on "Back"
  end

  test "updating a Preparo" do
    visit preparos_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @preparo.descricao
    fill_in "Nome", with: @preparo.nome
    fill_in "Tipo prova", with: @preparo.tipo_prova
    click_on "Update Preparo"

    assert_text "Preparo was successfully updated"
    click_on "Back"
  end

  test "destroying a Preparo" do
    visit preparos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Preparo was successfully destroyed"
  end
end
