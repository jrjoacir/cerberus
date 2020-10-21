require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should return all products' do
    get '/products'
    assert_response :success
    assert_equal @response.body, products.to_json
    assert_equal @response.code, '200'
  end

  test 'should return all products filter by client' do
    get "/clients/#{clients(:one).id}/products"
    assert_response :success
    assert_equal @response.body, contracts(:one).client.products.sort_by(&:id).reverse.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one product' do
    get "/products/#{products(:one).id}"
    assert_response :success
    assert_equal @response.body, products(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one product and its clients' do
    get "/products/#{products(:one).id}?show_clients=true"
    assert_response :success
    assert_equal @response.body, products(:one).to_json(include: :clients)
    assert_equal @response.code, '200'
  end

  test 'should return one product and an empty clients list' do
    get "/products/#{products(:three).id}?show_clients=true"
    assert_response :success
    assert_equal @response.body, products(:three).to_json(include: { clients: [] })
    assert_equal @response.code, '200'
  end

  test 'should return one product and its features' do
    get "/products/#{products(:one).id}?show_features=true"
    assert_response :success
    assert_equal @response.body, products(:one).to_json(include: :features)
    assert_equal @response.code, '200'
  end

  test 'should return one product and its features and its clients' do
    get "/products/#{products(:one).id}?show_features=true&show_clients=true"
    assert_response :success
    assert_equal @response.body, products(:one).to_json(include: %i[clients features])
    assert_equal @response.code, '200'
  end

  test 'should return one product and an empty features list' do
    get "/products/#{products(:three).id}?show_features=true"
    assert_response :success
    assert_equal @response.body, products(:three).to_json(include: { features: [] })
    assert_equal @response.code, '200'
  end

  test 'should return one product by client' do
    get "/clients/#{contracts(:one).client.id}/products/#{contracts(:one).product.id}"
    assert_response :success
    assert_equal @response.body, contracts(:one).product.to_json
    assert_equal @response.code, '200'
  end

  test 'should return one product by client and its clients' do
    get "/clients/#{contracts(:two).client.id}/products/#{contracts(:two).product.id}?show_clients=true"
    assert_response :success
    assert_equal @response.body, contracts(:two).product.to_json(include: :clients)
    assert_equal @response.code, '200'
  end

  test 'should return one product by client and its features' do
    get "/clients/#{contracts(:two).client.id}/products/#{contracts(:two).product.id}?show_features=true"
    assert_response :success
    assert_equal @response.body, contracts(:two).product.to_json(include: :features)
    assert_equal @response.code, '200'
  end

  test 'should return one product by client and an empty features list' do
    get "/clients/#{contracts(:four).client.id}/products/#{contracts(:four).product.id}?show_features=true"
    assert_response :success
    assert_equal @response.body, contracts(:four).product.to_json(include: { features: [] })
    assert_equal @response.code, '200'
  end

  test 'should raise not found error find by id' do
    get "/products/-#{products(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error find by client' do
    get "/clients/#{contracts(:one).client.id}/products/#{products(:three).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a product' do
    assert_difference('Product.count', 1) do
      post '/products',
           params: { name: 'Product-test', description: 'Product test description' }.to_json,
           headers: headers
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a product' do
    assert_no_difference('Product.count') do
      post '/products', params: { name: products(:one).name }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end

  test 'should update a product' do
    assert_no_difference('Product.count') do
      request_body = { name: 'Product-test-2', description: 'Description production teste 2' }
      put "/products/#{products(:one).id}", params: request_body.to_json, headers: headers
      body_hash = JSON.parse(@response.body).deep_symbolize_keys
      assert_response :success
      assert_equal body_hash[:name], request_body[:name]
      assert_equal body_hash[:description], request_body[:description]
      assert_equal @response.code, '200'
    end
  end

  test 'should raise unprocessable entity error on update a product with a duplicate name' do
    assert_no_difference('Product.count') do
      put "/products/#{products(:one).id}", params: { name: products(:two).name }.to_json, headers: headers
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
