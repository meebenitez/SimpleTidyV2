class ListsController < ApplicationController
  include ChoresHelper
  before_action :set_list, only: [:show, :edit, :update, :destroy, :join, :remove_user, :leave_list]
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    if can? :read, List
      @lists = current_user.lists
      @invites = current_user.invites.select {|invite| invite.status == "open" }
    else
      redirect_to root_path
    end
  end

  def new
    @list = List.new
    3.times do
      @list.invites.build
    end
  end

  def create
    @list  = List.create(list_params)
    @list.users << current_user
    @list.admin_id = current_user.id
    #Seed starter chores
    List.create_starter_list(@list)
    # assign invites
    List.send_invites_on_list_create(@list)

    #list.chores.make_chores(@list)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def show
    if @list
      Chore.set_chore_status(@list.chores)
      Chore.check_past_due(@list.chores)
      @daily_chores = create_chore_array_view("daily", @list.chores)
      @weekly_chores = create_chore_array_view("weekly", @list.chores)
      @monthly_chores = create_chore_array_view("monthly", @list.chores)
    else
      redirect_to lists_path
    end
  end


  #User accepts an invite to a list
  def join
    if @list
      #make sure user isn't already a member of the list (move this logic out eventually)
      if !@list.users.find_by(id: current_user.id) && @list.invites.find_by(email: current_user.email)
        @list.users << current_user
        #binding.pry
        invite = current_user.invites.find_by(list_id: @list.id)
        invite.status = "closed"
        invite.save
        redirect_to @list
      else
        redirect_to @list
      end
    else
      redirect_to lists_path
    end

  end

  #User is removed from a list by the admin
  def remove_user
    @list.users.delete(params[:user])
    redirect_to edit_list_path(@list.id)
  end

  def leave_list
    if current_user.id != @list.admin_id
      @list.users.delete(current_user)
      redirect_to lists_path
    else
      redirect_to list_path(@list)
    end
  end

  def edit
    if @list
      #binding.pry
      @daily_chores = create_chore_array_edit("daily", @list.chores)
      @weekly_chores = create_chore_array_edit("weekly", @list.chores)
      @monthly_chores = create_chore_array_edit("monthly", @list.chores)
    else
      redirect_to lists_path
    end
  end

  def update
    if @list
      @list.update(list_params)
      redirect_to edit_list_path(@list)
    else
      redirect_to lists_path
    end
  end

  def destroy
    if @list
      @list.destroy
      flash[:notice] = "deleted"
      redirect_to lists_path
    else
      redirect_to lists_path
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_type, invites_attributes: [:email, :status])
  end

  def set_list
    @list = List.find_by(id: params[:id])
  end


end
