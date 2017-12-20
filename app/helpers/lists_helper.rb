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
end
