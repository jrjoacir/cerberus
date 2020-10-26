require 'test_helper'

class FeaturesRoleControllerTest < ActionDispatch::IntegrationTest
  test 'should create feature-role association' do
    assert_difference('FeaturesRole.count', 1) do
      post "/features/#{features(:three).id}/roles/#{roles(:three).id}"
      assert_response :success
      expect_features_role = FeaturesRole.where(feature_id: features(:three).id, role_id: roles(:three).id).first
      assert_equal @response.body, expect_features_role.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should create role-feature association' do
    assert_difference('FeaturesRole.count', 1) do
      post "/roles/#{roles(:three).id}/features/#{features(:three).id}"
      assert_response :success
      expect_features_role = FeaturesRole.where(feature_id: features(:three).id, role_id: roles(:three).id).first
      assert_equal @response.body, expect_features_role.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate role-feature association' do
    assert_no_difference('FeaturesRole.count') do
      post "/roles/#{roles(:one).id}/features/#{features(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should raise unprocessable entity error on create a duplicate feature-role association' do
    assert_no_difference('FeaturesRole.count') do
      post "/features/#{features(:one).id}/roles/#{roles(:one).id}"
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should delete feature-role association' do
    assert_difference('FeaturesRole.count', -1) do
      delete "/features/#{features(:one).id}/roles/#{roles(:one).id}"
      assert_response :success
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should delete role-feature association' do
    assert_difference('FeaturesRole.count', -1) do
      delete "/roles/#{roles(:one).id}/features/#{features(:one).id}"
      assert_response :success
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should return 204 without delete any role-feature nonexistent association' do
    assert_no_difference('FeaturesRole.count') do
      delete "/roles/#{roles(:three).id}/features/#{features(:three).id}"
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end

  test 'should return 204 without delete any feature-role nonexistent association' do
    assert_no_difference('FeaturesRole.count') do
      delete "/features/#{features(:three).id}/roles/#{roles(:three).id}"
      assert_empty @response.body
      assert_equal @response.code, '204'
    end
  end
end
