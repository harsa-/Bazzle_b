class ChannelsController < ApplicationController
  # GET /channels
  # GET /channels.xml
  def index
    @channels = Channel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @channels }
    end
  end

  # GET /channels/1
  # GET /channels/1.xml
  def show
    @channel = Channel.find(params[:id])
    @posts = Post.find_all_by_channel_id(@channel.id.to_s, :order => "created_at DESC")  
    @last_refresh = Time.now

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @channel }
    end
  end

  # GET /channels/new
  # GET /channels/new.xml
  def new
    if (params[:tab] == 'who') || (params[:tab] == 'instructions')
      @tab = params[:tab]
    else
      @tab = 'create_channel_form'
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @channel }
      format.js
    end
  end

  # GET /channels/1/edit
  def edit
    @channel = Channel.find(params[:id])
  end

  # POST /channels
  # POST /channels.xml
  def create
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

  # PUT /channels/1
  # PUT /channels/1.xml
  def update
    @channel = Channel.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to(@channel, :notice => 'Channel was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @channel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.xml
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to(channels_url) }
      format.xml  { head :ok }
    end
  end
  
  def refresh
    @channel = Channel.find(params[:id])
    @posts = Post.find_all_by_channel_id(@channel.id.to_s, :order => "created_at DESC")
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page.replace_html "posts", :partial => @posts
        end
      }
    end
  end
  
  def show_modal
    
    @type = params[:type]
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page[@type].visual_effect 'toggle', 'appear'
        end
      }
    end
  end
  
  def hide_modal
    respond_to do |format|
      format.js {
        render :update do |page|
          page[@type].show
        end
      }
    end
  end
  
  def show_tab
    @tab = params[:tab]
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page[@tab].replace_html render(:partial => @tab)
        end
      }
    end
  end
end
