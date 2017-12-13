class ListsController < ApplicationController
  include ChoresHelper
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    if can? :read, List
      @lists = current_user.lists
      @invites = current_user.invites.select {|invite| invite.status == "open" }
      #binding.pry
    else
      redirect_to root_path
    end
  end


  def show
    authorize! :index, List
    @list = List.find(params[:id])
    @daily_chores = create_chore_array_view("daily", @list.chores)
    @weekly_chores = create_chore_array_view("weekly", @list.chores)
    @monthly_chores = create_chore_array_view("monthly", @list.chores)
  end

  def new
    @list = List.new
    @list.invites.build
    @list.invites.build
    @list.invites.build
  end


  def create
    @list  = List.create(list_params)
    @list.users << current_user
    @list.admin_id = current_user.id
    #Seed starter chores

    if @list.list_type == "Home"
      Chore::HOME_DATA[:chores].each do |chore|
        new_chore = @list.chores.new
        chore.each_with_index do |attribute, i|
          new_chore.send(Chore::HOME_DATA[:chore_keys][i]+"=", attribute)
          new_chore.reset_time = Chore.set_reset(Time.now, new_chore.frequency)
        end
        new_chore.save
        #binding.pry
      end
    elsif @list.list_type == "Car"
      Chore::CAR_DATA[:chores].each do |chore|
        new_chore = @list.chores.new
        chore.each_with_index do |attribute, i|
          new_chore.send(Chore::HOME_DATA[:chore_keys][i]+"=", attribute)
          new_chore.reset_time = Chore.set_reset(Time.now, new_chore.frequency)
        end
        new_chore.save
        #binding.pry
      end
    elsif @list.list_type == "Tech"
      Chore::TECH_DATA[:chores].each do |chore|
        new_chore = @list.chores.new
        chore.each_with_index do |attribute, i|
          new_chore.send(Chore::HOME_DATA[:chore_keys][i]+"=", attribute)
          new_chore.reset_time = Chore.set_reset(Time.now, new_chore.frequency)
        end
        new_chore.save
        #binding.pry
      end
    else
      Chore::CUSTOM_DATA[:chores].each do |chore|
        new_chore = @list.chores.new
        chore.each_with_index do |attribute, i|
          new_chore.send(Chore::HOME_DATA[:chore_keys][i]+"=", attribute)
          new_chore.reset_time = Chore.set_reset(Time.now, new_chore.frequency)
        end
        new_chore.save
        #binding.pry
      end
    end
    
    # assign invites
    @list.invites.each do |invite|
      if User.find_by(email: invite.email)
        @user = User.find_by(email: invite.email)
        @user.invites << invite
      end
    end


    #list.chores.make_chores(@list)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def join
    @list = List.find(params[:id])
    @list.users << current_user
    invite = current_user.invites.find_by(list_id: @list.id)
    invite.status = "closed"
    redirect_to @list

  end


  def edit
    @list = List.find(params[:id])
    @daily_chores = create_chore_array_edit("daily", @list.chores)
    @weekly_chores = create_chore_array_edit("weekly", @list.chores)
    @monthly_chores = create_chore_array_edit("monthly", @list.chores)
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_type, invites_attributes: [:email, :status])
  end



end
