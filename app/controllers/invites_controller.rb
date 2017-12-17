class InvitesController < ApplicationController
  before_action :set_list, only: [:show, :new, :create, :edit, :update, :destroy]

  def new
  end

  def create
    @invite = @list.invites.new(invite_params)
    if @invite.save
      @list.invites.each do |invite|
        if @user = User.find_by(email: invite.email)
          @user.invites << invite
        end
      end
      flash[:notice] = "Success"
      redirect_to edit_list_path(@list.id)
    else
      flash[:notice] = "Oh no!"
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