require 'rails_helper'

RSpec.feature "AddNewLists", type: :feature do
  it "should require the user log in before creating a list" do
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

  it "should allow the list creator to edit the list" do
    login_as create( :user ), scope: :user

    visit new_list_path

    within "#new_list" do
      fill_in "list_name", with: "My List"
    end

    click_link_or_button "Let's get started!"

    expect( List.count ).to eq(1)
    expect( List.first.name).to eq( "My List")

  end

  it "changes the list name and does not redirect", js: :true do
    login_as create( :user ), scope: :user

    l1 = List.create(name: "The Originals", list_type: "home")
    l1.users << User.all.first
    l1.creator_id = User.all.first.id
    List.create_starter_list(l1)
    l1.save
    ListsUser.set_admin(l1, User.all.first)
    visit edit_list_path(l1)
    fill_in "list_name", with: "The New Originals"
    click_link_or_button "Change Name"
    binding.pry
    expect(page.current_path).to eq edit_list_path(l1.id)
    expect(page).to have_content "The New Originals"
    
  end
    

    
    
    

end


