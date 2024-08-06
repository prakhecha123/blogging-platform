class CommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!
  
    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @post, notice: 'Comment added successfully.'
      else
        redirect_to @post, alert: 'Failed to add comment.'
      end
    end
  
    def edit
      @comment = @post.comments.find(params[:id])
    end
  
    def update
      @comment = @post.comments.find(params[:id])
      if @comment.update(comment_params)
        redirect_to @post, notice: 'Comment updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to @post, notice: 'Comment deleted successfully.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end

end