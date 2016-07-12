require 'test_helper'

class CounterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get counter_index_url
    assert_response :success
  end

  test "should get create" do
    get counter_create_url
    assert_response :success
  end
end
