require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
