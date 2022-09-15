require "application_system_test_case"

class VolumesTest < ApplicationSystemTestCase
  setup do
    @volume = volumes(:one)
  end

  test "visiting the index" do
    visit volumes_url
    assert_selector "h1", text: "Volumes"
  end

  test "should create volume" do
    visit volumes_url
    click_on "New volume"

    fill_in "Begin", with: @volume.begin
    fill_in "Code", with: @volume.code
    fill_in "End", with: @volume.end
    fill_in "Operator", with: @volume.operator
    fill_in "Region", with: @volume.region
    fill_in "Size", with: @volume.size
    fill_in "Unn", with: @volume.unn
    click_on "Create Volume"

    assert_text "Volume was successfully created"
    click_on "Back"
  end

  test "should update Volume" do
    visit volume_url(@volume)
    click_on "Edit this volume", match: :first

    fill_in "Begin", with: @volume.begin
    fill_in "Code", with: @volume.code
    fill_in "End", with: @volume.end
    fill_in "Operator", with: @volume.operator
    fill_in "Region", with: @volume.region
    fill_in "Size", with: @volume.size
    fill_in "Unn", with: @volume.unn
    click_on "Update Volume"

    assert_text "Volume was successfully updated"
    click_on "Back"
  end

  test "should destroy Volume" do
    visit volume_url(@volume)
    click_on "Destroy this volume", match: :first

    assert_text "Volume was successfully destroyed"
  end
end
