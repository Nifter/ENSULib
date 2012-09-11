class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    #raise params[:user].inspect    # Raises an exception with the params shown 
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to user_path(@user), :flash => { :success => "Welcome to the ENSU library catalogue!" }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id]) # takes the currently logged in user
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user]) # updates the data of @user from the params stored in params[:user]
      redirect_to user_path(@user), :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'      
    end
  end
  
  private
    def authenticate
      if !signed_in?
        # store the location of where the user originally wished to go as a session varialble
        deny_access
      end 
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
