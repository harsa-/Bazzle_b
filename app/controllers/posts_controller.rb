class PostsController < ApplicationController
  def index
    @posts = Post.all(:order => "created_at DESC")
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.create(:message => params[:message])
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path }
        format.js { @current_post = @post }
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to posts_path }
      end
    end
  end
end
