require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should return all users' do
    get '/users'
    assert_response :success
    assert_equal @response.body, users.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one user' do
    get "/users/#{users(:one).id}"
    assert_response :success
    assert_equal @response.body, users(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one user and its details' do
    get "/users/#{users(:one).id}?show_details=true"
    assert_response :success
    assert_equal @response.body, users(:one).to_hash.merge(details: users(:one).details_hash).to_json
    assert_equal @response.code, '200'
  end

  test 'should raise not found error' do
    get "/users/-#{users(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create an user' do
    assert_difference('User.count', 1) do
      post '/users',
           params: { user: { name: 'create-user-test', login: 'create-user-test@email.com.br' } }.to_json,
           headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create an user' do
    assert_no_difference('User.count') do
      post '/users', params: { user: { name: users(:one).name, login: users(:one).login } }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should delete one user and its dependents' do
    assert_difference('User.count', -1) do
      assert_difference('UsersRole.count', -2) do
        delete "/users/#{users(:one).id}"
        assert_response :success
        assert_empty @response.body
        assert_equal @response.code, '204'
      end
    end
  end

  test 'should delete no user and its dependents' do
    assert_no_difference('User.count') do
      assert_no_difference('UsersRole.count') do
        delete "/users/-#{users(:one).id}"
        assert_response :missing
        assert_equal @response.body, { message: 'Not Found' }.to_json
        assert_equal @response.code, '404'
      end
    end
  end

  test 'should update an user' do
    assert_no_difference('User.count') do
      request_body = { name: 'User-test-2', login: 'user-test-2-login' }
      put "/users/#{users(:one).id}", params: { user: request_body }.to_json, headers: headers
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal body_hash[:login], request_body[:login]
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update an user with a duplicate login' do
    assert_no_difference('User.count') do
      put "/users/#{users(:one).id}", params: { user: { login: users(:two).login } }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
