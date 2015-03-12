class UsersController < ApplicationController
	#index page
    def index
    @users = User.all
    end


    def show
    @user = User.find(params[:id])
    end

    def new
    @user = User.new
    end

    def edit
    @user = User.find(params[:id])
    end

    def create
    @user = User.new(user_params)

      if @user.save
      redirect_to dashboard_path, :flash => { :success => 'User was successfully created.' }
      else
      render :action => 'new'
    end
    end

    def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to dashboard_path, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
     @user.destroy
    redirect_to dashboard_path, :flash => { :success => 'User was successfully deleted.' }
    
  end

  def block #this will block the user
    @user = User.find(params[:id])
    @user.banned = true
    @user.save
   redirect_to dashboard_path, :flash => { :success => 'User was successfully blocked.' }
    end

def unblock #this will unblock the user
    @user = User.find(params[:id])
    @user.banned = false
    @user.save
   redirect_to dashboard_path, :flash => { :success => 'User was successfully Unblocked.' }
    

  end
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :birth_date, :image ,:username, :email, :password, :password_confirmation)
    end
end
