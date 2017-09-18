class LikesController < ApplicationController

	def like
	 if(!user_signed_in?)
	    redirect_to new_user_session_path
	    return
	  end
	  @user = current_user
	  @story = Story.find(params[:story_id])
	  if @user.liked?(@story)==-1
        @dislike = @user.dislikes.find_by_story_id(params[:story_id])
	  	@dislike.destroy!
      end
	  @user.likes.create!(story_id: @story.id)
	  redirect_to request.referer || root_path
	end

	def unlike
	  @user = current_user
	  #@story = Story.find(params[:story_id])
	  @like = @user.likes.find_by_story_id(params[:story_id])
	  @like.destroy!
	  redirect_to request.referer || root_path
	end

	def dislike
	 if(!user_signed_in?)
	    redirect_to new_user_session_path
	    return
	  end
	  @user = current_user
	  @story = Story.find(params[:story_id])
	  if @user.liked?(@story)==1
        @like = @user.likes.find_by_story_id(params[:story_id])
	  	@like.destroy!
      end
	  @user.dislikes.create!(story_id: @story.id)
	  redirect_to request.referer || root_path
	end

	def undislike
	  @user = current_user
	  #@story = Story.find(params[:story_id])
	  @dislike = @user.dislikes.find_by_story_id(params[:story_id])
	  @dislike.destroy!
	  redirect_to request.referer || root_path
	end

end
