class ChoresController < ApplicationController
  before_action :set_list, only: [:edit, :create, :update, :destroy]
  load_and_authorize_resource :list
  load_and_authorize_resource :chore, :through => :list
  before_action :authenticate_user!


  def create
    if @list
      now = Time.now
      @chore = @list.chores.build(chore_params)
      @chore.reset_time = Chore.set_reset(now, @chore.frequency)
      @chore.past_due_time = Chore.set_past_due(now, @chore.time_of_day, @chore.reset_time)
      if @chore.save
        flash[:notice] = "New Chore Successfully Created."
        redirect_to edit_list_path(@list.id)
      else
        flash[:notice] = "Oh no! Try that again."
        redirect_to edit_list_path(@list.id)
      end
    else
      redirect_to lists_path
    end
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
    #binding.pry
    flash[:notice] = "Chore Successfully Edited."
    redirect_to edit_list_path(@chore.list)
  end

  def complete
    @chore = Chore.find(params[:id])
    Chore.complete_chore(@chore)
    redirect_to list_path(@chore.list)
  end


  def destroy
    if @list
      @chore = @list.chores.find(params[:id])
      @chore.destroy
      flash[:notice] = "Chore successfully deleted!"
      redirect_to edit_list_path(@list)
    else
      redirect_to lists_path
    end
  end

  private 
    
    def chore_params
      params.require(:chore).permit(:name, :frequency, :time_of_day)
    end

    def set_list
      @list = List.find_by(id: params[:list_id])
    end


end

