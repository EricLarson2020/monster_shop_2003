class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
# binding.pry
  end

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  # def require_merchant
  #   render file: "/public/404" unless current_merchant?
  # end

end
