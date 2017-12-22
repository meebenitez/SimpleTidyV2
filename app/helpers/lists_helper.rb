module ListsHelper


  def list_type_photo(list)
      if list.list_type == "Home"
        url = "house.png"
      elsif list.list_type == "Car"
        url = "car.png"
      else
        url = "laptop.png"
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
