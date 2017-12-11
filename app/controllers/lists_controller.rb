class ListsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    if can? :read, List
      @lists = current_user.lists
    else
      redirect_to root_path
    end
  end


  def show
    authorize! :index, List
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
    @list.invites.build
  end


  def create
    @list  = List.create(list_params)
    @list.users << current_user
    @list.admin_id = current_user.id
    #Seed starter chores
    Chore::HOME_DATA[:chores].each do |chore|
      new_chore = @list.chores.new
      chore.each_with_index do |attribute, i|
        new_chore.send(Chore::HOME_DATA[:chore_keys][i]+"=", attribute)
      end
      new_chore.save
    end
    #list.chores.make_chores(@list)

    #binding.pry
    if @list.save
      #binding.pry
      redirect_to @list
    else
      render :new
    end
  end

  def join
    @list = List.find(params[:id])
    @list.users << current_user
  end


  def edit
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_type, invites_attributes: [:email])
  end



end
