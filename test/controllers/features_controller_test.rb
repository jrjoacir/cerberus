require 'test_helper'

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  test 'should return all features' do
    get '/features'
    assert_response :success
    assert_equal @response.body, features.to_json
    assert_equal @response.code, '200'
  end

  test 'should return features by paginate filter' do
    per_page = features.count - 1
    page = 2
    get "/features?per_page=#{per_page}&page=#{page}"
    assert_response :success
    assert_equal @response.body, features.last(1).to_json
    assert_equal @response.code, '200'
  end

  test 'should return all features filter by product' do
    get "/products/#{products(:one).id}/features"
    assert_response :success
    assert_equal @response.body, [features(:one), features(:two)].to_json
    assert_equal @response.code, '200'
  end

  test 'should return empty list features filter by product' do
    get '/products/-999/features'
    assert_response :success
    assert_equal @response.body, [].to_json
    assert_equal @response.code, '200'
  end

  test 'should return all features filter by contract and user' do
    get "/users/#{users(:four).id}/contracts/#{contracts(:one).id}/features"
    assert_response :success
    assert_equal @response.body, [features_roles(:three).feature, features_roles(:four).feature].to_json
    assert_equal @response.code, '200'
  end

  test 'should return empty list features filter by contract and user' do
    get "/users/#{users(:five).id}/contracts/#{contracts(:two).id}/features"
    assert_response :success
    assert_equal @response.body, [].to_json
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
    get "/products/#{features(:one).product.id}/features/#{features(:five).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a feature by product' do
    assert_difference('Feature.count', 1) do
      post "/products/#{products(:one).id}/features",
           params: { name: 'feature-test', enabled: true, read_only: false }.to_json,
           headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should create a feature' do
    assert_difference('Feature.count', 1) do
      post '/features',
           params: { product_id: products(:one).id, name: 'feature-test', enabled: true, read_only: false }.to_json,
           headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a feature by product' do
    assert_no_difference('Feature.count') do
      post "/products/#{products(:one).id}/features",
           params: { name: features(:two).name, enabled: true, read_only: false }.to_json,
           headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should raise unprocessable entity error on create a feature' do
    assert_no_difference('Feature.count') do
      post '/features',
           params: { product_id: products(:one).id, name: features(:two).name,
                     enabled: true, read_only: false }.to_json,
           headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should delete one feature and its dependents' do
    assert_difference('Feature.count', -1) do
      assert_difference('FeaturesRole.count', -2) do
        delete "/features/#{features(:one).id}"
        assert_response :success
        assert_empty @response.body
        assert_equal @response.code, '204'
      end
    end
  end

  test 'should delete no feature and its dependents' do
    assert_no_difference('Feature.count') do
      assert_no_difference('FeaturesRole.count') do
        delete "/features/-#{features(:one).id}"
        assert_response :missing
        assert_equal @response.body, { message: 'Not Found' }.to_json
        assert_equal @response.code, '404'
      end
    end
  end

  test 'should update a feature' do
    assert_no_difference('Feature.count') do
      request_body = { name: 'Feature-test-2', product_id: products(:two).id,
                       enabled: !features(:one).enabled, read_only: !features(:one).read_only }
      put "/features/#{features(:one).id}", params: request_body.to_json, headers: headers
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal body_hash[:product_id], request_body[:product_id]
      assert_equal body_hash[:enabled], !features(:one).enabled
      assert_equal body_hash[:read_only], !features(:one).read_only
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update a feature with a duplicate name' do
    assert_no_difference('Feature.count') do
      put "/features/#{features(:one).id}",
          params: { name: features(:two).name, enabled: true, read_only: true }.to_json,
          headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
