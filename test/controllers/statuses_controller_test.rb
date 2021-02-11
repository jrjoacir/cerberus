require 'test_helper'

class StatusesControllerTest < ActionDispatch::IntegrationTest
  test 'should return statuses' do
    get '/statuses'
    response_body_database = JSON.parse(@response.body)['database']
    assert_response :success
    assert_equal @response.code, '200'
    assert_equal response_body_database['message'], 'Database Connection Success'
    assert_equal response_body_database['status'], 'success'
    assert response_body_database['duration'] >= 0.0
  end
end
