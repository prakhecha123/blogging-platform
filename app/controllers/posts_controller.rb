class PostsController < ApplicationController
    before_action :set_post, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user, only: [:edit, :update, :destroy]
  
    def index
      @posts = Post.search(params[:query]).page(params[:page])
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Post created successfully.'
      else
        render :new
      end
    end
  
    def show
        @post = Post.find_by(id: params[:id])
        if @post
          # Post found, proceed with rendering the view
        else
          # Post not found, handle the case
          redirect_to posts_path, alert: 'Post not found.'
        end
    end
  
    def edit; end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_path, notice: 'Post deleted successfully.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
  
    def authorize_user
      unless current_user.admin? || current_user == @post.user
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
end