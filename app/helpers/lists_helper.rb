module ListsHelper


  def list_type_photo(list)
      pastdue = check_list_past_due(list)
      if list.list_type == "Home" && pastdue
        url = "home_red.png"
      elsif list.list_type == "Home"
        url = "home_black.png"
      elsif list.list_type == "Car" && pastdue
        url = "car_red.png"
      elsif list.list_type == "Car"
        url = "car_black.png"
      elsif pastdue
        url = "laptop_red.png"
      else
        url = "laptop_black.png"
      end
  end

  def check_list_past_due(list)
    list.chores.any? {|chore| chore.past_due == true }
  end

  def check_admin?(list, user)
    ListsUser.find_by(list_id: list.id, user_id: user.id).admin
  end


  #return a list of users who are only members and not the creator
  def non_creators(list, users)
    members = []
    users.each do |user|
      if !List.is_creator?(list, user)
        members << user
      end
    end
    members
  end



end
