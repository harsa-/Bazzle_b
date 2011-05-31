class ChannelsController < ApplicationController
  # GET /channels
  # GET /channels.xml
  def index
    redirect_to :action => "new"
  end

  # GET /channels/1
  # GET /channels/1.xml
  def show
    if (is_number?(params[:id]))
      render :file => "public/no_channel.html"
    else
    
      begin
        @channel = Channel.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render :file => "public/no_channel.html"
      else
        @posts = Post.find_all_by_channel_id(@channel.id.to_s, :order => "created_at DESC")  
        @last_refresh = Time.now
    
        if (params[:tab] == 'create_channel_form')
          @tab = 'create_channel_form'
          @new_visibility = "display:block"
          @channel_visibility = "display:none"
          @instruction_visibility = "display:none"
        elsif (params[:tab] == 'instructions')
          @tab = 'instructions'
          @new_visibility = "display:none"
          @channel_visibility = "display:none"
          @instruction_visibility = "display:block"
        else
          @tab = 'channel'
          @new_visibility = "display:none"
          @channel_visibility = "display:block"
          @instruction_visibility = "display:none"
        end

        respond_to do |format|
          format.html # show.html.erb
          format.js
          format.xml  { render :xml => @channel }
        end
      end
    end
  end

  # GET /channels/new
  # GET /channels/new.xml
  def new
    if (params[:tab] == 'who')
      @tab = params[:tab]
      @who_visibility = "display:block"
      @instruction_visibility = "display:none"
      @create_visibility = "display:none"
    elsif (params[:tab] == 'instructions')
      @tab = params[:tab]
      @who_visibility = "display:none"
      @instruction_visibility = "display:block"
      @create_visibility = "display:none"
    else
      @tab = 'create_channel_form'
      @who_visibility = "display:none"
      @instruction_visibility = "display:none"
      @create_visibility = "display:block"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @channel }
      format.js
    end
  end

  # GET /channels/1/edit
  def edit
    render :file => "public/404.html"
  end

  # POST /channels
  # POST /channels.xml
  def create
    if is_number?(params[:name])
      redirect_to :action => "new" and flash[:notice] = 'Channel name cannot be a number!'
    elsif params[:name] == ""
      redirect_to :action => "new" and flash[:notice] = 'Channel name cannot be empty!'
    elsif params[:description] == ""
      redirect_to :action => "new" and flash[:notice] = 'Channel description cannot be empty!'      
    else
      @channel = Channel.new(:name => params[:name], :description => params[:description])
      respond_to do |format|
        if @channel.save
          format.html { redirect_to(@channel, :notice => 'Channel was successfully created.') }
          format.xml  { render :xml => @channel, :status => :created, :location => @channel }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @channel.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /channels/1
  # PUT /channels/1.xml
  def update
    render :file => "public/404.html"
  end

  # DELETE /channels/1
  # DELETE /channels/1.xml
  def destroy
    render :file => "public/404.html"
  end
  
end
