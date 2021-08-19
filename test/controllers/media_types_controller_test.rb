require "test_helper"

class MediaTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @media_type = media_types(:one)
  end

  test "should get index" do
    get media_types_url, as: :json
    assert_response :success
  end

  test "should create media_type" do
    assert_difference('MediaType.count') do
      post media_types_url, params: { media_type: { name: @media_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show media_type" do
    get media_type_url(@media_type), as: :json
    assert_response :success
  end

  test "should update media_type" do
    patch media_type_url(@media_type), params: { media_type: { name: @media_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy media_type" do
    assert_difference('MediaType.count', -1) do
      delete media_type_url(@media_type), as: :json
    end

    assert_response 204
  end
end
