class Admin::DashboardController < AdminController
  def index
    @customers = Customer.all
    current_user
  end
end
