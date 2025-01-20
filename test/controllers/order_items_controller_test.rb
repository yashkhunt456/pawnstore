require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get order_items_edit_url
    assert_response :success
  end
end
