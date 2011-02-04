require 'test_helper'

class CustomOrdersControllerTest < ActionController::TestCase
  setup do
    @custom_order = custom_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_order" do
    assert_difference('CustomOrder.count') do
      post :create, :custom_order => @custom_order.attributes
    end

    assert_redirected_to custom_order_path(assigns(:custom_order))
  end

  test "should show custom_order" do
    get :show, :id => @custom_order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @custom_order.to_param
    assert_response :success
  end

  test "should update custom_order" do
    put :update, :id => @custom_order.to_param, :custom_order => @custom_order.attributes
    assert_redirected_to custom_order_path(assigns(:custom_order))
  end

  test "should destroy custom_order" do
    assert_difference('CustomOrder.count', -1) do
      delete :destroy, :id => @custom_order.to_param
    end

    assert_redirected_to custom_orders_path
  end
end
