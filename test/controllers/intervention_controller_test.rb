require 'test_helper'

class InterventionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get intervention_index_url
    assert_response :success
  end

end
