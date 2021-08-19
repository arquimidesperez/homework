require "test_helper"

class FilmActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @film_actor = film_actors(:one)
  end

  test "should get index" do
    get film_actors_url, as: :json
    assert_response :success
  end

  test "should create film_actor" do
    assert_difference('FilmActor.count') do
      post film_actors_url, params: { film_actor: { actor_id: @film_actor.actor_id, film_id: @film_actor.film_id, last_update: @film_actor.last_update } }, as: :json
    end

    assert_response 201
  end

  test "should show film_actor" do
    get film_actor_url(@film_actor), as: :json
    assert_response :success
  end

  test "should update film_actor" do
    patch film_actor_url(@film_actor), params: { film_actor: { actor_id: @film_actor.actor_id, film_id: @film_actor.film_id, last_update: @film_actor.last_update } }, as: :json
    assert_response 200
  end

  test "should destroy film_actor" do
    assert_difference('FilmActor.count', -1) do
      delete film_actor_url(@film_actor), as: :json
    end

    assert_response 204
  end
end
