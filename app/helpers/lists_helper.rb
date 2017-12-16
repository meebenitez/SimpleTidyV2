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
end
