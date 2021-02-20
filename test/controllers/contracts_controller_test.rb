require 'test_helper'

class ContractControllerTest < ActionDispatch::IntegrationTest
  test 'should create contract' do
    assert_difference('Contract.count', 1) do
      post '/contracts',
           params: { client_id: clients(:three).id, product_id: products(:three).id, enabled: true }.to_json,
           headers: headers
      expect_contract = Contract.where(product_id: products(:three).id, client_id: clients(:three).id).first
      assert_response :success
      assert_equal @response.body, expect_contract.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate contract' do
    assert_no_difference('Contract.count') do
      post '/contracts',
           params: { client_id: clients(:one).id, product_id: products(:one).id, enabled: true }.to_json,
           headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should return all contracts' do
    get '/contracts'
    assert_response :success
    assert_equal @response.body, contracts.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all contracts and show product details' do
    get '/contracts?show_product_details=true'
    assert_response :success
    assert_equal @response.body, contracts.to_json(include: :product)
    assert_equal @response.code, '200'
  end

  test 'should return all contracts and show client details' do
    get '/contracts?show_client_details=true'
    assert_response :success
    assert_equal @response.body, contracts.to_json(include: :client)
    assert_equal @response.code, '200'
  end

  test 'should return all contracts filter by user' do
    get "/users/#{users(:one).id}/contracts"
    assert_response :success
    assert_equal @response.body, users(:one).roles.map(&:contract).uniq.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all contracts filter by user and show product details' do
    get "/users/#{users(:one).id}/contracts?show_product_details=true"
    assert_response :success
    assert_equal @response.body, users(:one).roles.map(&:contract).uniq.to_json(include: :product)
    assert_equal @response.code, '200'
  end

  test 'should return all contracts filter by user and show client details' do
    get "/users/#{users(:one).id}/contracts?show_client_details=true"
    assert_response :success
    assert_equal @response.body, users(:one).roles.map(&:contract).uniq.to_json(include: :client)
    assert_equal @response.code, '200'
  end
end
