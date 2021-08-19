class MediaTypesController < ApplicationController
  before_action :set_media_type, only: [:show, :update, :destroy]

  # GET /media_types
  def index
    @media_types = MediaType.all

    render json: @media_types
  end

  # GET /media_types/1
  def show
    render json: @media_type
  end

  # POST /media_types
  def create
    @media_type = MediaType.new(media_type_params)

    if @media_type.save
      render json: @media_type, status: :created, location: @media_type
    else
      render json: @media_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media_types/1
  def update
    if @media_type.update(media_type_params)
      render json: @media_type
    else
      render json: @media_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /media_types/1
  def destroy
    @media_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_type
      @media_type = MediaType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def media_type_params
      params.require(:media_type).permit(:name)
    end
end
