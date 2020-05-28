class LogoutController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    session.delete(:user_id)
    session.delete(:cart)
    flash[:notice] = "You have logged out"
    redirect_to "/"

  end


end
