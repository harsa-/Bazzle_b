module PostsHelper
  def update_time
    page.replace_html 'seconds_remaining', self.seconds_remaining
  end
end
