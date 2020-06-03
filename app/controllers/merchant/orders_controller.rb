class Merchant::OrdersController < ApplicationController

  def show
    binding.pry
    @merchant = current_user.merchant
  end

end
