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
    assert_equal @response.body, [clients_products(:one).product].to_json
    assert_equal @response.code, '200'
  end

  test 'should return one product' do
    get "/products/#{products(:one).id}"
    assert_response :success
    assert_equal @response.body, products(:one).to_json
    assert_equal @response.code, '200'
  end

  test 'should return one product by client' do
    get "/clients/#{clients_products(:one).client.id}/products/#{clients_products(:one).product.id}"
    assert_response :success
    assert_equal @response.body, clients_products(:one).product.to_json
    assert_equal @response.code, '200'
  end

  test 'should raise not found error find by id' do
    get "/products/-#{products(:one).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should raise not found error find by client' do
    get "/clients/#{clients_products(:one).client.id}/products/#{products(:three).id}"
    assert_response :missing
    assert_equal @response.body, { message: 'Not Found' }.to_json
    assert_equal @response.code, '404'
  end

  test 'should create a product' do
    assert_difference('Product.count', 1) do
      post '/products', params: { product: { name: 'Product-test', description: 'Product test description' } }
      assert_response :success
      assert_equal @response.code, '201'
    end
  end

  test 'should raise unprocessable entity error on create a product' do
    assert_no_difference('Product.count') do
      post '/products', params: { product: { name: products(:one).name } }
      assert_equal @response.body, { message: 'Unprocessable Entity' }.to_json
      assert_equal @response.code, '422'
    end
  end
end
