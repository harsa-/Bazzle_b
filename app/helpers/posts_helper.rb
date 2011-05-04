module PostsHelper
  def update_time
    page.replace_html 'seconds_remaining', self.seconds_remaining
  end
  
  def destroy_countdown
    render (:update) do |page|
      
    end
  end
end