class PostsController < ApplicationController
  
  def index
    @posts = Post.all(:order => "created_at DESC")
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.create(:message => params[:message], 
                        :channel_id => params[:channel_id], 
                        :channel_name => params[:channel_name],
                        :session_id => session[:session_id])
    
    respond_to do |format|
      if @post.save
        format.js if request.xhr?
        format.html { redirect_to posts_path }
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to posts_path }
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.can_destroy? session[:session_id]
       @post.destroy

    
       respond_to do |format|
         format.js if request.xhr?
         format.html { redirect_to channels_path }
       end
    end
  end
  
  def update_time
    render(:update) { |page| page.update_time }
  end
      
end
