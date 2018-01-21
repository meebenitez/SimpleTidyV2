require 'rails_helper'

RSpec.feature "AddNewLists", type: :feature do
  it "should require the user log in before adding a post" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit lists_path

    within "#new_user" do
      fill_in "user_email", with: u.email
      fill_in "user_password", with: password
    end

    click_button "Log in"

    visit new_list_path

    within "#new_list" do
      fill_in "list_name", with: "List title"
    end

    click_link_or_button "Let's get started!"

    expect( List.count ).to eq(1)
    expect( List.first.name).to eq( "List title")
  end
end

