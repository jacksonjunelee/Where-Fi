class UsersController < ApplicationController

	before_action :authenticate, except: [:new, :create]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "User Created! Please Log-in Below."
			redirect_to @user
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
		if @user != current_user
			render :home
		end
	end
#change redirection if user not current user

	def update
		@user = User.find(params[:id])
		if @user != current_user
			render :home
		else
			if @user.update(user_params)
				redirect_to @user
			else
				render :edit
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to @user
		else
			@user.destroy
			session[:current_user_id] = nil
			render :home
		end
	end

	def add_location
		user_location = Location.find(params[:location_id])
		user = User.find(session[:current_user_id])
		user.locations.push(user_location)
		user_location.fav_point += 1
		user_location.save
		redirect_to user
	end

	def remove_location
		user_location = Location.find(params[:location_id])
		user = User.find(session[:current_user_id])
		user.locations.destroy(user_location) if user.locations.include? user_location
		user_location.fav_point -= 1
		redirect_to user
	end

	private

	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
	end

end
