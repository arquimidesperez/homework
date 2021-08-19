require "test_helper"

class FilmCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @film_category = film_categories(:one)
  end

  test "should get index" do
    get film_categories_url, as: :json
    assert_response :success
  end

  test "should create film_category" do
    assert_difference('FilmCategory.count') do
      post film_categories_url, params: { film_category: { category_id: @film_category.category_id, film_id: @film_category.film_id, last_update: @film_category.last_update } }, as: :json
    end

    assert_response 201
  end

  test "should show film_category" do
    get film_category_url(@film_category), as: :json
    assert_response :success
  end

  test "should update film_category" do
    patch film_category_url(@film_category), params: { film_category: { category_id: @film_category.category_id, film_id: @film_category.film_id, last_update: @film_category.last_update } }, as: :json
    assert_response 200
  end

  test "should destroy film_category" do
    assert_difference('FilmCategory.count', -1) do
      delete film_category_url(@film_category), as: :json
    end

    assert_response 204
  end
end
