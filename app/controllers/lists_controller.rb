class ListsController < ApplicationController
  include ChoresHelper
  before_action :set_list, only: [:show, :edit, :update, :destroy, :join, :edit_members, :remove_user, :leave_list]
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    if can? :read, List
      @lists = current_user.lists
      #grab user's open invites for display
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
    #add user to the list.users and then assign them as the creator
    if @list.valid?
      @list.users << current_user
      @list.creator_id = current_user.id

      #Seed starter chores
      List.create_starter_list(@list)
      # assign invites
      List.send_invites_on_list_create(@list)
      if @list.save
        ListsUser.set_admin(@list, current_user)
        flash[:notice] = ""
        redirect_to @list
      else
        flash[:notice] = "List creation failed.  Try again."
        redirect_to new_list_path
      end
    else
      flash[:notice] = @list.errors.full_messages.to_sentence
      redirect_to new_list_path
    end
  end

  def show
    #change status and past_due values
    Chore.set_chore_status(@list.chores)
    Chore.check_past_due(@list.chores)
    #grab chore arrays sorted by frequency for display
    @todo_chores = create_chore_array_view(@list.chores)
    @done_chores = create_chore_array_view_completed(@list.chores)
    @daily_chores = create_chore_array_view_frequency("daily", @list.chores)
    @weekly_chores = create_chore_array_view_frequency("weekly", @list.chores)
    @monthly_chores = create_chore_array_view_frequency("monthly", @list.chores)
    respond_to do |f|
      f.json { render json: @list, status: 200}
      f.html {render :show}
    end
  end


  #User accepts an invite to a list
  def join
    #make sure user isn't already a member of the list and that they have an open invite exiting
    if !@list.users.find_by(id: current_user.id) && @list.invites.exists?(email: current_user.email, status: "open")
      @list.users << current_user
      invite = current_user.invites.find_by(list_id: @list.id)
      #close out the invite
      invite.status = "closed"
      invite.save
      redirect_to @list
    else
      flash[:notice] = "Not a valid invite."
      redirect_to @list
    end

  end

  #User is removed from a list by the admin
  def remove_user
    @list.users.delete(params[:user])
    redirect_to edit_list_path(@list.id)
  end

  #User chooses to unsubscribe from a list (not available to the list creator)
  def leave_list
    if current_user.id != @list.creator_id
      @list.users.delete(current_user)
      redirect_to lists_path
    else
      flash[:notice] = "You are the creator of this list and cannot unsubscribe."
      redirect_to list_path(@list)
    end
  end

  def edit
    @daily_chores = create_chore_array_edit("daily", @list.chores)
    @weekly_chores = create_chore_array_edit("weekly", @list.chores)
    @monthly_chores = create_chore_array_edit("monthly", @list.chores)
  end

  def update
    @list.update(list_params)
    respond_to do |f|
      f.json { render json: @list, status: 200}
      f.html {redirect_to edit_list_path(@list.id)}
    end
  end

  def edit_members

  end

  def destroy
    @list.destroy
    flash[:notice] = "#{@list.name} was deleted."
    redirect_to lists_path
  end


  private

  def list_params
    params.require(:list).permit(:name, :list_type, invites_attributes: [:email, :status], users_attributes: [:id, :name, :enable])
  end

  def set_list
    if !@list = List.find_by(id: params[:id])
      flash[:notice] = "List did not exist."
      redirect_to lists_path
    end
  end


end
