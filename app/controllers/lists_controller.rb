class ListsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    authorize! :index, List
    @lists = List.all
  end


  def show
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

  def edit
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end



end
