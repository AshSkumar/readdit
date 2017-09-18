class StoriesController < ApplicationController
	def new
		:authenticate_user!
		if(!user_signed_in?)
    		redirect_to new_user_session_path
  		end
		@story = Story.new
	end

	def create
		:authenticate_user!
		@user = current_user

		@story = @user.stories.build(profile_params)
		if @story.save
	       flash[:success] = "Story posted!"
	       redirect_to story_path(@story.id)
	    else
	       render action: :new
	    end
	end


	def index
		@user = current_user
	end

	def show
		 @story = Story.find(params[:id])
		 @user = current_user
	end

	private
      # Whitelist the form fields to prevent hackers from
      # adding additional form fields
      def profile_params
        params.require(:story).permit(:title, :body, :url)
      end
end
