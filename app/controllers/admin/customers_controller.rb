class Admin::CustomersController < Admin::BaseController

	def index
		@customers = Customer.all
	end

	def show
		@customer = Customer.find(params[:id])
	end

	private
	def admin_admin_user_params
	end
end
