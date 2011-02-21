require 'test_helper'

class Admin::CustomOrdersControllerTest < ActionController::TestCase
  setup do
    @admin_custom_order = admin_custom_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_custom_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_custom_order" do
    assert_difference('Admin::CustomOrder.count') do
      post :create, :admin_custom_order => @admin_custom_order.attributes
    end

    assert_redirected_to admin_custom_order_path(assigns(:admin_custom_order))
  end

  test "should show admin_custom_order" do
    get :show, :id => @admin_custom_order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_custom_order.to_param
    assert_response :success
  end

  test "should update admin_custom_order" do
    put :update, :id => @admin_custom_order.to_param, :admin_custom_order => @admin_custom_order.attributes
    assert_redirected_to admin_custom_order_path(assigns(:admin_custom_order))
  end

  test "should destroy admin_custom_order" do
    assert_difference('Admin::CustomOrder.count', -1) do
      delete :destroy, :id => @admin_custom_order.to_param
    end

    assert_redirected_to admin_custom_orders_path
  end
end
