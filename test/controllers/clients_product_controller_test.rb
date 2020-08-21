require 'test_helper'

class ClientsProductControllerTest < ActionDispatch::IntegrationTest
  test 'should create client-product association' do
    assert_difference('ClientsProduct.count', 1) do
      post "/clients/#{clients(:three).id}/products/#{products(:three).id}"
      assert_response :success
      assert_equal @response.body, ClientsProduct.where(product_id: products(:three).id, client_id: clients(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should create product-client association' do
    assert_difference('ClientsProduct.count', 1) do
      post "/products/#{products(:three).id}/clients/#{clients(:three).id}"
      assert_response :success
      assert_equal @response.body, ClientsProduct.where(product_id: products(:three).id, client_id: clients(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate client-product association' do
    assert_no_difference('ClientsProduct.count') do
      post "/clients/#{clients(:one).id}/products/#{products(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate product-client association' do
    assert_no_difference('ClientsProduct.count') do
      post "/products/#{products(:one).id}/clients/#{clients(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
