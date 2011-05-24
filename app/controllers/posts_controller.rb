class PostsController < ApplicationController
  
  def show
    @channel = Channel.find(params[:channel_id])
    @posts = Post.find_all_by_channel_id(@channel.id.to_s, :order => "created_at DESC")
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page.replace_html "posts", :partial => @posts
        end
      }
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

end