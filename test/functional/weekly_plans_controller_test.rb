require 'test_helper'

class WeeklyPlansControllerTest < ActionController::TestCase
  setup do
    @weekly_plan = weekly_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekly_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekly_plan" do
    assert_difference('WeeklyPlan.count') do
      post :create, weekly_plan: { category_id: @weekly_plan.category_id, number_of_hours: @weekly_plan.number_of_hours, start_date: @weekly_plan.start_date }
    end

    assert_redirected_to weekly_plan_path(assigns(:weekly_plan))
  end

  test "should show weekly_plan" do
    get :show, id: @weekly_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weekly_plan
    assert_response :success
  end

  test "should update weekly_plan" do
    put :update, id: @weekly_plan, weekly_plan: { category_id: @weekly_plan.category_id, number_of_hours: @weekly_plan.number_of_hours, start_date: @weekly_plan.start_date }
    assert_redirected_to weekly_plan_path(assigns(:weekly_plan))
  end

  test "should destroy weekly_plan" do
    assert_difference('WeeklyPlan.count', -1) do
      delete :destroy, id: @weekly_plan
    end

    assert_redirected_to weekly_plans_path
  end
end
