class PostsController < ApplicationController
  
  # takes offset and timestamp as parameters
  def index
#    if params[:timestamp]
#      @posts = Post.order("created_at DESC").where("created_at > ? AND channel_id = ?", params[:timestamp].to_datetime, params[:channel_id])
#      @timestamp = params[:timestamp]
#    else
      @posts = Post.find_all_by_channel_id(params[:channel_id], :order => "created_at DESC")
#    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @posts = Post.find_all_by_channel_id(params[:channel_id], :order => "created_at DESC")
    
    respond_to do |format|
      format.html { render }
      format.js {
        render :update do |page|
          page.replace_html "posts", render(:partial => "posts/post", :collection => @posts)
        end
      }
    end
  end

  def create
    @message = params[:message] #.split_after(100)
    
    @post = Post.create(:message => @message, 
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
      if @post
       @post.destroy
      end

    
       respond_to do |format|
         format.js if request.xhr?
         format.html { redirect_to channels_path }
       end
    end
  end   

end