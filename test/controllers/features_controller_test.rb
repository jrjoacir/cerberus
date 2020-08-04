require 'test_helper'

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  test 'should return all features' do
    get '/features'
    assert_response :success
    assert_equal @response.body, features.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all features filter by product' do
    get "/products/#{products(:one).id}/features"
    assert_response :success
    assert_equal @response.body, [features(:one), features(:two)].to_json
    assert_equal @response.code, '200'
  end

  test 'should return one feature' do
    get "/features/#{features(:one).id}"
    assert_response :success
    assert_equal @response.body, features(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one feature by product' do
    get "/products/#{features(:one).product.id}/features/#{features(:one).id}"
    assert_response :success
    assert_equal @response.body, features(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should raise not found error when find by id' do
    get "/features/-#{features(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error when find by product' do
    get "/products/#{features(:one).product.id}/features/-#{features(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a feature' do
    assert_difference('Feature.count', 1) do
      post "/products/#{products(:one).id}/features", params: { feature: { name: 'feature-test' } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a feature' do
    assert_no_difference('Feature.count') do
      post "/products/#{products(:one).id}/features", params: { feature: { name: features(:two).name } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
