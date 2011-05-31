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
      format.js
      format.html { redirect_to Channel.find(params[:channel_id]) }
    end
  end
  
  def show
    render :file => "public/404.html"
  end

  def create
    @message = params[:message] #.split_after(100)
    @channel = Channel.find(params[:channel_id])
    @post = Post.create(:message => @message, 
                        :channel_id => params[:channel_id], 
                        :channel_name => params[:channel_name],
                        :session_id => session[:session_id])
    
    respond_to do |format|
      if @post.save
        format.js if request.xhr?
        format.html { redirect_to @channel }
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to @channel }
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