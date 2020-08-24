require 'test_helper'

class ContractControllerTest < ActionDispatch::IntegrationTest
  test 'should create contract' do
    assert_difference('Contract.count', 1) do
      post '/contracts', params: {client_id: clients(:three).id, product_id: products(:three).id}
      assert_response :success
      assert_equal @response.body, Contract.where(product_id: products(:three).id, client_id: clients(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate contract' do
    assert_no_difference('Contract.count') do
      post '/contracts', params: {client_id: clients(:one).id, product_id: products(:one).id}
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
