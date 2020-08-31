require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'should return all clients' do
    get '/clients'
    assert_response :success
    assert_equal @response.body, clients.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all clients filter by product' do
    get "/products/#{products(:one).id}/clients"
    assert_response :success
    assert_equal @response.body, [contracts(:one).client, contracts(:two).client].to_json
    assert_equal @response.code, '200'
  end

  test 'should return one client' do
    get "/clients/#{clients(:one).id}"
    assert_response :success
    assert_equal @response.body, clients(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one client and its products' do
    get "/clients/#{clients(:two).id}?show_products=true"
    assert_response :success
    assert_equal @response.body, clients(:two).to_json(include: :products)
    assert_equal @response.code, '200'
  end

  test 'should return one client and an empty products list' do
    get "/clients/#{clients(:three).id}?show_products=true"
    assert_response :success
    assert_equal @response.body, clients(:three).to_json(include: { products: [] })
    assert_equal @response.code, '200'
  end

  test 'should return one client by product' do
    get "/products/#{contracts(:one).product.id}/clients/#{contracts(:one).client.id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).client.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one client by product and its products' do
    get "/products/#{contracts(:two).product.id}/clients/#{contracts(:two).client.id}?show_products=true"
    assert_response :success
    assert_equal @response.body, contracts(:two).client.to_json(include: :products)
    assert_equal @response.code, '200'
  end

  test 'should raise not found error find by id' do
    get "/clients/-#{clients(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error find by product' do
    get "/products/#{contracts(:one).product.id}/clients/#{clients(:three).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a client' do
    assert_difference('Client.count', 1) do
      post '/clients', params: { client: { name: 'Client-test' } }.to_json, headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a client' do
    assert_no_difference('Client.count') do
      post '/clients', params: { client: { name: clients(:one).name } }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should update a client' do
    assert_no_difference('Client.count') do
      request_body = { name: 'Client-test-2' }
      put "/clients/#{clients(:one).id}", params: { client: request_body }.to_json, headers: headers
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update a client with a duplicate name' do
    assert_no_difference('Client.count') do
      put "/clients/#{clients(:one).id}", params: { client: { name: clients(:two).name } }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
