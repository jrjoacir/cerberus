require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  test 'should return all roles' do
    get '/roles'
    assert_response :success
    assert_equal @response.body, roles.to_json
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
    get "/products/#{contracts(:one).product_id}/clients/#{contracts(:one).client_id}/roles/#{contracts(:one).roles.first.id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by product and client' do
    get "/products/#{contracts(:one).product_id}/clients/#{contracts(:one).client_id}/roles/#{contracts(:one).roles.first.id}?show_users=true"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json(include: :users)
    assert_equal @response.code, '200'
  end

  test 'should return one role find by client and product' do
    get "/clients/#{contracts(:one).client_id}/products/#{contracts(:one).product_id}/roles/#{contracts(:one).roles.first.id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).roles.first.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one role and its users find by client and product' do
    get "/clients/#{contracts(:one).client_id}/products/#{contracts(:one).product_id}/roles/#{contracts(:one).roles.first.id}?show_users=true"
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
    get "/products/#{contracts(:one).product_id}/clients/#{contracts(:one).client_id}/roles/#{contracts(:two).roles.first.id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when try to find role by client and product' do
    get "/clients/#{contracts(:one).client_id}/products/#{contracts(:one).product_id}/roles/#{contracts(:two).roles.first.id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create an role' do
    assert_difference('Role.count', 1) do
      post '/roles', params: { role: { name: 'create-role-test', product_id: contracts(:four).product_id, client_id: contracts(:four).client_id } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create an role' do
    assert_no_difference('Role.count') do
      post '/roles', params: { role: { name: roles(:one).name, product_id: roles(:one).contract.product_id, client_id: roles(:one).contract.client_id } }
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
          delete "/products/#{roles(:one).contract.product_id}/clients/#{roles(:one).contract.client_id}/roles/#{roles(:one).id}"
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
          delete "/clients/#{roles(:one).contract.client_id}/products/#{roles(:one).contract.product_id}/roles/#{roles(:one).id}"
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
          delete "/roles/-3"
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
          delete "/clients/-1/products/-2/roles/-3"
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
          delete "/products/-1/clients/-2/roles/-3"
          assert_response :missing
          assert_equal @response.body, { message: 'Not Found' }.to_json
          assert_equal @response.code, '404'
        end
      end
    end
  end

  test 'should update a role' do
    assert_no_difference('Role.count') do
      request_body = { name: 'Role-test-2', product_id: contracts(:two).product_id, client_id: contracts(:two).client_id }
      put "/roles/#{roles(:one).id}", params: { role: request_body }
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal body_hash[:contract_id], contracts(:two).id
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update a feature with a duplicate name' do
    assert_no_difference('Feature.count') do
      put "/features/#{features(:one).id}", params: { feature: { name: features(:two).name } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
