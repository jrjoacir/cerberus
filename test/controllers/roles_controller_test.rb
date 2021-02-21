require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  test 'should return all roles' do
    get '/roles'
    assert_response :success
    assert_equal @response.body, roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return roles by paginate filter' do
    per_page = roles.count - 1
    page = 2
    get "/roles?per_page=#{per_page}&page=#{page}"
    assert_response :success
    assert_equal @response.body, roles.last(1).to_json
    assert_equal @response.code, '200'
  end

  test 'should return all roles find by product and client' do
    get "/products/#{contracts(:one).product_id}/clients/#{contracts(:one).client_id}/roles"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all roles find by client and product' do
    get "/clients/#{contracts(:one).client_id}/products/#{contracts(:one).product_id}/roles"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.to_json
    assert_equal @response.code, '200'
  end

  test 'should return an empty roles list find by product and client' do
    get "/products/#{contracts(:three).product_id}/clients/#{contracts(:three).client_id}/roles"
    assert_response :success
    assert_equal @response.body, [].to_json
    assert_equal @response.code, '200'
  end

  test 'should return an empty roles list find by client and product' do
    get "/clients/#{contracts(:three).client_id}/products/#{contracts(:three).product_id}/roles"
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
    product_id = contracts(:one).product_id
    client_id = contracts(:one).client_id
    role_id = contracts(:one).roles.first.id
    get "/products/#{product_id}/clients/#{client_id}/roles/#{role_id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by product and client' do
    product_id = contracts(:one).product_id
    client_id = contracts(:one).client_id
    role_id = contracts(:one).roles.first.id
    get "/products/#{product_id}/clients/#{client_id}/roles/#{role_id}?show_users=true"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should return one role find by client and product' do
    product_id = contracts(:one).product_id
    client_id = contracts(:one).client_id
    role_id = contracts(:one).roles.first.id
    get "/clients/#{client_id}/products/#{product_id}/roles/#{role_id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by client and product' do
    client_id = contracts(:one).client_id
    product_id = contracts(:one).product_id
    role_id = contracts(:one).roles.first.id
    get "/clients/#{client_id}/products/#{product_id}/roles/#{role_id}?show_users=true"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should raise not found error' do
    get "/roles/-#{roles(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when try to find role by product and client' do
    client_id = contracts(:one).client_id
    product_id = contracts(:one).product_id
    role_id = contracts(:two).roles.first.id
    get "/products/#{product_id}/clients/#{client_id}/roles/#{role_id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when try to find role by client and product' do
    client_id = contracts(:one).client_id
    product_id = contracts(:one).product_id
    role_id = contracts(:two).roles.first.id
    get "/clients/#{client_id}/products/#{product_id}/roles/#{role_id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create an role' do
    assert_difference('Role.count', 1) do
      post '/roles',
           params: { name: 'create-role-test', contract_id: contracts(:four).id, enabled: true }.to_json,
           headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create an role' do
    assert_no_difference('Role.count') do
      post '/roles',
           params: { name: roles(:one).name, contract_id: roles(:one).contract.id, enabled: true }.to_json,
           headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should delete one role and its dependents' do
    assert_difference('Role.count', -1) do
      assert_difference('UsersRole.count', -2) do
        assert_difference('FeaturesRole.count', -1) do
          delete "/roles/#{roles(:one).id}"
          assert_response :success
          assert_empty @response.body
          assert_equal @response.code, '204'
        end
      end
    end
  end

  test 'should delete one role and its dependents find by product and client' do
    assert_difference('Role.count', -1) do
      assert_difference('UsersRole.count', -2) do
        assert_difference('FeaturesRole.count', -1) do
          client_id = roles(:one).contract.client_id
          product_id = roles(:one).contract.product_id
          role_id = roles(:one).id
          delete "/products/#{product_id}/clients/#{client_id}/roles/#{role_id}"
          assert_response :success
          assert_empty @response.body
          assert_equal @response.code, '204'
        end
      end
    end
  end

  test 'should delete one role and its dependents find by client and product' do
    assert_difference('Role.count', -1) do
      assert_difference('UsersRole.count', -2) do
        assert_difference('FeaturesRole.count', -1) do
          client_id = roles(:one).contract.client_id
          product_id = roles(:one).contract.product_id
          role_id = roles(:one).id
          delete "/clients/#{client_id}/products/#{product_id}/roles/#{role_id}"
          assert_response :success
          assert_empty @response.body
          assert_equal @response.code, '204'
        end
      end
    end
  end

  test 'should delete no role and its dependents' do
    assert_no_difference('Role.count') do
      assert_no_difference('UsersRole.count') do
        assert_no_difference('FeaturesRole.count') do
          delete '/roles/-3'
          assert_response :missing
          assert_equal @response.body, { message: 'Not Found' }.to_json
          assert_equal @response.code, '404'
        end
      end
    end
  end

  test 'should delete no role and its dependents find by client and product' do
    assert_no_difference('Role.count') do
      assert_no_difference('UsersRole.count') do
        assert_no_difference('FeaturesRole.count') do
          delete '/clients/-1/products/-2/roles/-3'
          assert_response :missing
          assert_equal @response.body, { message: 'Not Found' }.to_json
          assert_equal @response.code, '404'
        end
      end
    end
  end

  test 'should delete no role and its dependents find by product and client' do
    assert_no_difference('Role.count') do
      assert_no_difference('UsersRole.count') do
        assert_no_difference('FeaturesRole.count') do
          delete '/products/-1/clients/-2/roles/-3'
          assert_response :missing
          assert_equal @response.body, { message: 'Not Found' }.to_json
          assert_equal @response.code, '404'
        end
      end
    end
  end

  test 'should update a role' do
    assert_no_difference('Role.count') do
      request_body = { name: 'Role-test-2', contract_id: contracts(:two).id, enabled: !roles(:one).enabled }
      put "/roles/#{roles(:one).id}", params: request_body.to_json, headers: headers
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal body_hash[:contract_id], contracts(:two).id
      assert_equal body_hash[:enabled], !roles(:one).enabled
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update a role with a duplicate name' do
    assert_no_difference('Role.count') do
      request_body = { name: roles(:two).name, contract_id: roles(:two).contract_id, enabled: true }
      put "/roles/#{roles(:one).id}", params: request_body.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
