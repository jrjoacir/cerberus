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
    assert_equal @response.body, [clients_products(:one).client, clients_products(:two).client].to_json
    assert_equal @response.code, '200'
  end

  test 'should return one client' do
    get "/clients/#{clients(:one).id}"
    assert_response :success
    assert_equal @response.body, clients(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one client by product' do
    get "/products/#{clients_products(:one).product.id}/clients/#{clients_products(:one).client.id}"
    assert_response :success
    assert_equal @response.body, clients_products(:one).client.to_json
    assert_equal @response.code, '200'
  end

  test 'should raise not found error find by id' do
    get "/clients/-#{clients(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error find by product' do
    get "/clients/#{clients_products(:one).client.id}/products/-#{clients_products(:one).product.id}"
    get "/products/#{clients_products(:one).product.id}/clients/-#{clients_products(:one).client.id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a client' do
    assert_difference('Client.count', 1) do
      post '/clients', params: { client: { name: 'Client-test' } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a client' do
    assert_no_difference('Client.count') do
      post '/clients', params: { client: { name: clients(:one).name } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
