require "application_system_test_case"

class TasksкфшдыsTest < ApplicationSystemTestCase
  setup do
    @tasksкфшды = tasksкфшдыs(:one)
  end

  test "visiting the index" do
    visit tasksкфшдыs_url
    assert_selector "h1", text: "Tasksкфшдыs"
  end

  test "creating a Tasksкфшды" do
    visit tasksкфшдыs_url
    click_on "New Tasksкфшды"

    fill_in "ы", with: @tasksкфшды.ы
    click_on "Create Tasksкфшды"

    assert_text "Tasksкфшды was successfully created"
    click_on "Back"
  end

  test "updating a Tasksкфшды" do
    visit tasksкфшдыs_url
    click_on "Edit", match: :first

    fill_in "ы", with: @tasksкфшды.ы
    click_on "Update Tasksкфшды"

    assert_text "Tasksкфшды was successfully updated"
    click_on "Back"
  end

  test "destroying a Tasksкфшды" do
    visit tasksкфшдыs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tasksкфшды was successfully destroyed"
  end
end
