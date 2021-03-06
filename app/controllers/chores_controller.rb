class ChoresController < ApplicationController
  before_action :set_list, only: [:edit, :create, :update, :destroy, :show]
  load_and_authorize_resource :list
  load_and_authorize_resource :chore, :through => :list
  before_action :authenticate_user!

  def create
    #binding.pry
    now = Time.now
    @chore = @list.chores.build(chore_params)
    if @chore.valid?
      @chore.reset_time = Chore.set_reset(now, @chore.frequency)
      @chore.past_due_time = Chore.set_past_due(now, @chore.time_of_day, @chore.reset_time)
      if @chore.save
        respond_to do |f|
          f.json { render json: @chore, status: 200}
          f.html {redirect_to edit_list_path(@list.id)}
        end    
      else
        flash[:notice] = "Oh no! Try that again."
        redirect_to edit_list_path(@list.id)
      end
    else
      flash[:notice] = "Chore " + @chore.errors.full_messages.to_sentence
      redirect_to edit_list_path(@list.id)
    end
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def show
    @chore = Chore.find(params[:id])
    render json: @chore, status: 200
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
    if @chore.valid?
      flash[:notice] = "Chore Successfully Edited."
      redirect_to edit_list_path(@chore.list)
    else
      flash[:notice] = @chore.errors.full_messages.to_sentence
      redirect_to edit_list_chore_path(@chore.list, @chore)
    end
  end

  def complete
    @chore = Chore.find(params[:id])
    Chore.complete_chore(@chore)
    respond_to do |f|
      f.json { render json: @chore, status: 200}
      f.html {redirect_to list_path(@chore.list)}
    end
    #redirect_to list_path(@chore.list)
  end


  def destroy
    @chore = @list.chores.find(params[:id])
    @chore.destroy
    flash[:notice] = "Chore successfully deleted!"
    respond_to do |f|
      f.json { render json: @chore, status: 200}
      f.html {redirect_to edit_list_path(@list.id)}
    end
  end

  private 
    
    def chore_params
      params.require(:chore).permit(:name, :frequency, :time_of_day)
    end

    def set_list
      if !@list = List.find_by(id: params[:list_id])
        flash[:notice] = "List did not exist."
        redirect_to lists_path
      end
    end


end

