class CommentsController < ApplicationController

	def new 
		@comment = Comment.new
		@location = Location.find(params[:location_id])
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.save
		redirect_to @comment.location
	end

	def destroy 
		Comment.destroy(params[:id])
		redirect_to root_path
	end

	private 

	def comment_params
		params.require(:comment).permit(:content, :location_id, :user_id)
	end


end