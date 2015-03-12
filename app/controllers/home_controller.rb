class HomeController < ApplicationController
	#index page of the application 
	def index

	
	end
	def show
    	@user = User.find(params[:id])
  	end

	
end
