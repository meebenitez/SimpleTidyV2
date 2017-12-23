class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @user_created_lists = List.where_creator(@user.id)   
  end
end
