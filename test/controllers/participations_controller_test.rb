require 'test_helper'

class ParticipationsControllerTest < ActionDispatch::IntegrationTest
  test "should get participate" do
    get participations_participate_url
    assert_response :success
  end

end
