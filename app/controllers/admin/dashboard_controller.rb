class Admin::DashboardController < ApplicationController

    before_action :require_admin

    def show
      @admin = current_user
      @users = User.all
      @orders = Order.all
      @packaged_orders = Order.packaged_orders
      @pending_orders = Order.pending_orders
      @shipped_orders = Order.shipped_orders
      @cancelled_orders = Order.cancelled_orders
      @admin_dash_uri = '/admin/dashboard'
    end

    private
    def require_admin
      render file: "/public/404" unless current_admin?
    end

end
