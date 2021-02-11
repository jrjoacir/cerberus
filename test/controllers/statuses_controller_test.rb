require 'test_helper'

class StatusesControllerTest < ActionDispatch::IntegrationTest
  test 'should return statuses' do
    get '/statuses'
    expect_response_body = { 'status' => 'operational', 'services' => { 'database' => 'operational' } }.to_json
    assert_response :success
    assert_equal @response.code, '200'
    assert_equal @response.body, expect_response_body
  end
end
