module InvitesHelper


  def list_name(list_id)
    List.find_by(id: list_id).name
  end


end
