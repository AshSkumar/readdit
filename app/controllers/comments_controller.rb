class CommentsController < ApplicationController
before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user_id = current_user.id
      if(params[:type] == 'comment')
        @comment.story_id = @commentable.story_id
      else
        @comment.story_id = @commentable.id
      end

      if @comment.save
        redirect_to request.referer || root_path
        flash[:success] = "Your comment was successfully posted!"
      else
        redirect_to request.referer || root_path
        flash[:danger] = @comment.errors.full_messages.join(", ")
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Story.find_by_id(params[:story_id]) if params[:story_id]
    end

end