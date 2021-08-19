class FilmCategoriesController < ApplicationController
  before_action :set_film_category, only: [:show, :update, :destroy]

  # GET /film_categories
  def index
    @film_categories = FilmCategory.all

    render json: @film_categories
  end

  # GET /film_categories/1
  def show
    render json: @film_category
  end

  # POST /film_categories
  def create
    @film_category = FilmCategory.new(film_category_params)

    if @film_category.save
      render json: @film_category, status: :created, location: @film_category
    else
      render json: @film_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /film_categories/1
  def update
    if @film_category.update(film_category_params)
      render json: @film_category
    else
      render json: @film_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /film_categories/1
  def destroy
    @film_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film_category
      @film_category = FilmCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def film_category_params
      params.require(:film_category).permit(:film_id, :category_id, :last_update)
    end
end
