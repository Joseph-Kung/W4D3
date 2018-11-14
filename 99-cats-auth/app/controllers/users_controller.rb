class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  
  
  
  
  
  private
  def require_login
    redirect_to new_user_url unless current_user
  end
end