class Admin::PageController < Admin::BaseController

	def index
		render layout: "admin"
	end
	def login
	end

	def logout
	end

	private
	def admin_admin_user_params
	end
end
