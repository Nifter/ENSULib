module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token # if @current_user is nil, it gets assigned the value returned from user_from_remember_token
  end

  def signed_in?
    !current_user.nil? # calls the current_user method. If it returns a user, then signed in, otherwise not signed in
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def is_active?(controller_name, page_name)
    "active" if (params[:controller] == controller_name && params[:action] == page_name)
  end


  def authenticate
    if !signed_in?
      # store the location of where the user originally wished to go as a session varialble
      deny_access
    end
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token) # '*' unwraps the array 'remember_token' and passes in the contents of the array as each different argument
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
