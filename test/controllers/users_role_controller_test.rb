require 'test_helper'

class UsersRoleControllerTest < ActionDispatch::IntegrationTest
  test 'should create user-role association' do
    assert_difference('UsersRole.count', 1) do
      post "/users/#{users(:three).id}/roles/#{roles(:three).id}"
      assert_response :success
      assert_equal @response.body, UsersRole.where(users_id: users(:three).id, roles_id: roles(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should create role-user association' do
    assert_difference('UsersRole.count', 1) do
      post "/roles/#{roles(:three).id}/users/#{users(:three).id}"
      assert_response :success
      assert_equal @response.body, UsersRole.where(users_id: users(:three).id, roles_id: roles(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate role-user association' do
    assert_no_difference('UsersRole.count') do
      post "/roles/#{roles(:one).id}/users/#{users(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate user-role association' do
    assert_no_difference('UsersRole.count') do
      post "/users/#{users(:one).id}/roles/#{roles(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should delete user-role association' do
    assert_difference('UsersRole.count', -1) do
      delete "/users/#{users(:one).id}/roles/#{roles(:one).id}"
      assert_response :success
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should delete role-user association' do
    assert_difference('UsersRole.count', -1) do
      delete "/roles/#{roles(:one).id}/users/#{users(:one).id}"
      assert_response :success
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should return 204 without delete any role-user nonexistent association' do
    assert_no_difference('UsersRole.count') do
      delete "/roles/#{roles(:three).id}/users/#{users(:three).id}"
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should return 204 without delete any user-role nonexistent association' do
    assert_no_difference('UsersRole.count') do
      delete "/users/#{users(:three).id}/roles/#{roles(:three).id}"
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end
end
