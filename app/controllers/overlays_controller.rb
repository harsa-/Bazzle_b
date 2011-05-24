class OverlaysController < ApplicationController
  
  def show
    
    respond_to do |format|
      format.js if request.xhr? {
        render :partial => param[:overlay_type], :layout => none
      }
    end
  end
end