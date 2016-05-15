require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
  end


  test "cantidad es numero" do
  	cantidad = ApiController.new().getCantidad('melipillazo', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
    assert_not_nil(cantidad, 'malo')
  end



  test "get data " do
  	data = ApiController.new().getPost('melipillazo', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
    assert_not_nil(data, 'malo')
  end

  test "get postx" do
  	data = ApiController.new().getPost('melipillazo', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  	postx = ApiController.new().getPostx(data,0)
    assert_not_nil(postx, 'malo')
end

  test "token malo" do
  	get :buscar, :tag => 'melipillazo', :access_token => 'TOKEN'
    assert_response :bad_request
  end

  test "token bueno" do
  	get :buscar, :tag => 'melipillazo', :access_token => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    assert_response :success
  end


end
