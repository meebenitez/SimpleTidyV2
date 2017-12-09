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
  end


  def create
    @list  = List.new(list_params)
    @list.users << current_user
    @list.admin_id = current_user.id
    if @list.save
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
    params.require(:list).permit(:name)
  end



end
