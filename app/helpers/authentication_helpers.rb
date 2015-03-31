helpers do

  def login_as_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    p session[:user_id]
  end

  # def logged_in?
  #   !!current_user
  # end

  def is_current_user?(user)
    if current_user == user.id
      return true
    else
      return false
    end
  end

  def logout!
    session.clear
  end

end