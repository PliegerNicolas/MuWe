require 'test_helper'

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get followers_show_url
    assert_response :success
  end

  test "should get follow" do
    get followers_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get followers_unfollow_url
    assert_response :success
  end

end
