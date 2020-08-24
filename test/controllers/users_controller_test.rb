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
      post '/users', params: { user: { name: 'create-user-test', login: 'create-user-test@email.com.br' } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create an user' do
    assert_no_difference('User.count') do
      post '/users', params: { user: { name: users(:one).name, login: users(:one).login } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
