class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart
  helper_method :current_user, :current_admin?, :current_merchant?, :current_uri

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_uri
    current_uri = request.env['PATH_INFO']
  end

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end


  # def admin?
  #   role == 2
  # end
  #
  # def merchant?
  #   role == 1
  # end

end
