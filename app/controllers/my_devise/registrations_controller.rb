class MyDevise::RegistrationsController < Devise::RegistrationsController

  def destroy
    current_user.lists.each do |list|
      check_list = List.find(list.id)
      if check_list.admin_id == current_user.id
        list.destroy
      end
    end
    super
  end
end