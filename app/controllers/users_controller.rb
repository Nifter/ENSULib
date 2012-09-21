class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 20)
    @title = "All users"
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(:page => params[:page])
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

  # Do not need to define a @user in edit and update since doing it in a before_filter correct_user
  def edit
    #@user = User.find(params[:id]) # takes the currently logged in user
    @title = "Edit user"
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user]) # updates the data of @user from the params stored in params[:user]
      redirect_to user_path(@user), :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => {:success => "User destroyed."}
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
