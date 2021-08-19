require "test_helper"

class FilmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @film = films(:one)
  end

  test "should get index" do
    get films_url, as: :json
    assert_response :success
  end

  test "should create film" do
    assert_difference('Film.count') do
      post films_url, params: { film: { description: @film.description, fulltext: @film.fulltext, language_id: @film.language_id, last_update: @film.last_update, length: @film.length, rating: @film.rating, release_year: @film.release_year, rental_duration: @film.rental_duration, rental_rate: @film.rental_rate, replacement_cost: @film.replacement_cost, special_features: @film.special_features, title: @film.title } }, as: :json
    end

    assert_response 201
  end

  test "should show film" do
    get film_url(@film), as: :json
    assert_response :success
  end

  test "should update film" do
    patch film_url(@film), params: { film: { description: @film.description, fulltext: @film.fulltext, language_id: @film.language_id, last_update: @film.last_update, length: @film.length, rating: @film.rating, release_year: @film.release_year, rental_duration: @film.rental_duration, rental_rate: @film.rental_rate, replacement_cost: @film.replacement_cost, special_features: @film.special_features, title: @film.title } }, as: :json
    assert_response 200
  end

  test "should destroy film" do
    assert_difference('Film.count', -1) do
      delete film_url(@film), as: :json
    end

    assert_response 204
  end
end
