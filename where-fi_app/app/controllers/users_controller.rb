class UsersController < ApplicationController

	before_action :authenticate, except: [:new, :create]
	# syntax wrong

	def show
		@user = User.find(params[:id])
	end
	#need authenticate

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render :edit
		end
	end

	def destroy
		User.destroy(params[:id])
		render :home
	end

	def add_location
		user_location = Location.find(params[:location_id])
		user = User.find(session[:current_user_id])
		user.locations.push(user_location)
		redirect_to user
	end

	def remove_location
		user_location = Location.find(params[:location_id])
		user = User.find(session[:current_user_id])
		user.locations.destroy(user_location) if user.locations.include? user_location
		redirect_to user
	end

	private

	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
	end

end
