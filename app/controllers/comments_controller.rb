class CommentsController < ApplicationController
	def index
		
	end
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment])
		redirect_to post_url(@post)
	end
end
