class InvitesController < ApplicationController
  before_action :set_list, only: [:show, :new, :create, :edit, :update, :destroy]
  load_and_authorize_resource :invite, :through => :list

  def new
  end

  def create
      @invite = @list.invites.build(invite_params)
      if !Invite.duplicate_invite?(@list, @invite.email) && @invite.email != current_user.email && !Invite.already_member?(@list, @invite.email)
        if @invite.save
          @list.invites.each do |invite|
            if @user = User.find_by(email: invite.email)
              @user.invites << invite
            end
          end
          flash[:success] = "Invite successfully sent to #{@invite.email}"
          redirect_to edit_list_path(@list.id)
        else
          flash[:notice] = "Oh no! Something terrible happened.  Please try again."
          redirect_to edit_list_path(@list.id)
        end
      elsif @invite.email == current_user.email
        flash[:alert] = "You can't invite yourself."
        redirect_to edit_list_path(@list.id)
      elsif Invite.already_member?(@list, @invite.email)
        flash[:alert] = "That email belongs to a current member of your list."
        redirect_to edit_list_path(@list.id)
      else
        flash[:alert] = "That email already has a pending invite"
        redirect_to edit_list_path(@list.id)
      end
  end

   private 
    
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_list
      @list = List.find(params[:list_id])
    end

end