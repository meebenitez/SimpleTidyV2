class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    super
    if current_user
      current_user.update(name: params[:user][:name])
      current_user.invites << Invite.all.select {|invite| invite.email == current_user.email }
    end
  end

  def destroy
    current_user.lists.each do |list|
      check_list = List.find(list.id)
      if check_list.creator_id == current_user.id
        list.destroy
      end
    end
    super
  end

end