require 'test_helper'

class FeaturesRoleControllerTest < ActionDispatch::IntegrationTest
  test 'should create feature-role association' do
    assert_difference('FeaturesRole.count', 1) do
      post "/features/#{features(:three).id}/roles/#{roles(:three).id}"
      assert_response :success
      assert_equal @response.body, FeaturesRole.where(features_id: features(:three).id, roles_id: roles(:three).id).first.to_json
      assert_equal @response.code, '201'
    end
  end

  test 'should create role-feature association' do
    assert_difference('FeaturesRole.count', 1) do
      post "/roles/#{roles(:three).id}/features/#{features(:three).id}"
      assert_response :success
      assert_equal @response.body, FeaturesRole.where(features_id: features(:three).id, roles_id: roles(:three).id).first.to_json
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
end
