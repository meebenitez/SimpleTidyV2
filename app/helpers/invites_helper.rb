module InvitesHelper


  def list_name(list_id)
    if list = List.find_by(id: list_id)
      list.name
    else
      nil
    end
  end

  def list_type_photo(list_id)
    if list = List.find_by(id: list_id)
      if list.list_type == "home"
        url = "#{house.png}"
      elsif list.list_type == "car"
        url = "#{car.png}"
      else
        url = "#{laptop.png}"
      end
    else
      nil
    end
  end


end
