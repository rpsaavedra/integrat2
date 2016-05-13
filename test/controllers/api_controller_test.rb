require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get buscar" do
    get :buscar
    assert_response :success
  end

end
