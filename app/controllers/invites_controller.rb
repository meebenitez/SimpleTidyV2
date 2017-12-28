class InvitesController < ApplicationController
  before_action :set_list, only: [:new, :create]
  load_and_authorize_resource :invite, :through => :list

  def new
  end

  def create
      @invite = @list.invites.build(invite_params)
      #check that there is not a duplicate invite for this list and that the email is valid
      if !Invite.duplicate_invite?(@list, @invite.email) && @invite.email != current_user.email && !Invite.already_member?(@list, @invite.email)
        if @invite.save
          Invite.send_invite(@invite)
          flash[:success] = "Invite successfully sent to #{@invite.email}"
          redirect_to edit_list_path(@list.id)
        else
          flash[:notice] = "Oh no! Please make sure you entered a valid email."
          redirect_to new_list_invite_path(@list.id)
        end
      elsif @invite.email == current_user.email
        flash[:alert] = "You can't invite yourself."
        redirect_to new_list_invite_path(@list.id)
      elsif Invite.already_member?(@list, @invite.email)
        flash[:alert] = "That email belongs to a current member of your list."
        redirect_to new_list_invite_path(@list.id)
      else
        flash[:alert] = "That email already has a pending invite"
        redirect_to new_list_invite_path(@list.id)
      end
  end

   private 
    
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_list
      if !@list = List.find_by(id: params[:list_id])
        flash[:notice] = "List did not exist."
        redirect_to lists_path
      end
    end

end