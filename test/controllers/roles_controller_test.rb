require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  test 'should return all roles' do
    get '/roles'
    assert_response :success
    assert_equal @response.body, roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all roles find by product and client' do
    get "/products/#{clients_products(:one).product_id}/clients/#{clients_products(:one).client_id}/roles"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all roles find by client and product' do
    get "/clients/#{clients_products(:one).client_id}/products/#{clients_products(:one).product_id}/roles"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return an empty roles list find by product and client' do
    get "/products/#{clients_products(:three).product_id}/clients/#{clients_products(:three).client_id}/roles"
    assert_response :success
    assert_equal @response.body, [].to_json
    assert_equal @response.code, '200'
  end

  test 'should return an empty roles list find by client and product' do
    get "/clients/#{clients_products(:three).client_id}/products/#{clients_products(:three).product_id}/roles"
    assert_response :success
    assert_equal @response.body, [].to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role' do
    get "/roles/#{roles(:one).id}"
    assert_response :success
    assert_equal @response.body, roles(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users' do
    get "/roles/#{roles(:one).id}?show_users=true"
    assert_response :success
    assert_equal @response.body, roles(:one).to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should return one role find by product and client' do
    get "/products/#{clients_products(:one).product_id}/clients/#{clients_products(:one).client_id}/roles/#{clients_products(:one).roles.first.id}"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by product and client' do
    get "/products/#{clients_products(:one).product_id}/clients/#{clients_products(:one).client_id}/roles/#{clients_products(:one).roles.first.id}?show_users=true"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.first.to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should return one role find by client and product' do
    get "/clients/#{clients_products(:one).client_id}/products/#{clients_products(:one).product_id}/roles/#{clients_products(:one).roles.first.id}"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by client and product' do
    get "/clients/#{clients_products(:one).client_id}/products/#{clients_products(:one).product_id}/roles/#{clients_products(:one).roles.first.id}?show_users=true"
    assert_response :success
    assert_equal @response.body, clients_products(:one).roles.first.to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should raise not found error' do
    get "/roles/-#{roles(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when try to find role by product and client' do
    get "/products/#{clients_products(:one).product_id}/clients/#{clients_products(:one).client_id}/roles/#{clients_products(:two).roles.first.id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when try to find role by client and product' do
    get "/clients/#{clients_products(:one).client_id}/products/#{clients_products(:one).product_id}/roles/#{clients_products(:two).roles.first.id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create an role' do
    assert_difference('Role.count', 1) do
      post '/roles', params: { role: { name: 'create-role-test', product_id: clients_products(:four).product_id, client_id: clients_products(:four).client_id } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create an role' do
    assert_no_difference('Role.count') do
      post '/roles', params: { role: { name: roles(:one).name, product_id: roles(:one).clients_products.product_id, client_id: roles(:one).clients_products.client_id } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
