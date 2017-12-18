class ChoresController < ApplicationController
  before_action :set_list, only: [:new, :create, :edit, :update, :destroy]
  respond_to :html, :json
  
  def new
  end


  def create
    now = Time.now
    @chore = @list.chores.new(chore_params)
    @chore.reset_time = Chore.set_reset(now, @chore.frequency)
    @chore.past_due_time = Chore.set_past_due(now, @chore.time_of_day, @chore.reset_time)

    if @chore.save
      flash[:notice] = "Success"
      redirect_to edit_list_path(@list.id)
    else
      flash[:notice] = "Oh no!"
      redirect_to edit_list_path(@list.id)
    end
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
    redirect_to list_path(@chore.list)
  end

  def show
  end

  def complete
    @chore = Chore.find(params[:id])
    Chore.complete_chore(@chore)
    redirect_to list_path(@chore.list)
  end


  def destroy
    @chore = @list.chores.find(params[:id])
    @chore.destroy
    flash[:notice] = "deleted"
    redirect_to edit_list_path(@list)
  end

  private 
    
    def chore_params
      params.require(:chore).permit(:name, :frequency, :time_of_day)
    end

    def set_list
      @list = List.find(params[:list_id])
    end


end

