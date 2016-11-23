require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get homepage_home_url
    assert_response :success
  end

  test "should get services" do
    get homepage_services_url
    assert_response :success
  end

  test "should get department_1" do
    get homepage_department_1_url
    assert_response :success
  end

  test "should get department_2" do
    get homepage_department_2_url
    assert_response :success
  end

  test "should get department_3" do
    get homepage_department_3_url
    assert_response :success
  end

  test "should get department_4" do
    get homepage_department_4_url
    assert_response :success
  end

  test "should get help_1" do
    get homepage_help_1_url
    assert_response :success
  end

  test "should get help_2" do
    get homepage_help_2_url
    assert_response :success
  end

  test "should get help_3" do
    get homepage_help_3_url
    assert_response :success
  end

  test "should get info_1" do
    get homepage_info_1_url
    assert_response :success
  end

  test "should get info_2" do
    get homepage_info_2_url
    assert_response :success
  end

  test "should get info_3" do
    get homepage_info_3_url
    assert_response :success
  end

end
