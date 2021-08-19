class FilmActorsController < ApplicationController
  before_action :set_film_actor, only: [:show, :update, :destroy]

  # GET /film_actors
  def index
    @film_actors = FilmActor.all

    render json: @film_actors
  end

  # GET /film_actors/1
  def show
    render json: @film_actor
  end

  # POST /film_actors
  def create
    @film_actor = FilmActor.new(film_actor_params)

    if @film_actor.save
      render json: @film_actor, status: :created, location: @film_actor
    else
      render json: @film_actor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /film_actors/1
  def update
    if @film_actor.update(film_actor_params)
      render json: @film_actor
    else
      render json: @film_actor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /film_actors/1
  def destroy
    @film_actor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film_actor
      @film_actor = FilmActor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def film_actor_params
      params.require(:film_actor).permit(:actor_id, :film_id, :last_update)
    end
end
