module InvitesHelper


  def list_name(list_id)
    if list = List.find_by(id: list_id)
      list.name
    else
      nil
    end
  end

  def list_object(list_id)
    if list = List.find_by(id: list_id)
      list
    else
      nil
    end
  end

  

  


end
