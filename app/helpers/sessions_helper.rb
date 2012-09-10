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
  
  private  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token) # '*' unwraps the array 'remember_token' and passes in the contents of the array as each different argument
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
