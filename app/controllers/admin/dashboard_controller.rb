class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.all
    current_user
  end
end
