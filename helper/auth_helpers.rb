module AuthHelper

  def admin?
    session[:admin] == true
  end

  def authenticate!
    redirect '/login' unless admin?
  end

end