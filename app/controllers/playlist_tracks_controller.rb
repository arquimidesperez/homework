class PlaylistTracksController < ApplicationController
  before_action :set_playlist_track, only: [:show, :update, :destroy]

  # GET /playlist_tracks
  def index
    @playlist_tracks = PlaylistTrack.all

    render json: @playlist_tracks
  end

  # GET /playlist_tracks/1
  def show
    render json: @playlist_track
  end

  # POST /playlist_tracks
  def create
    @playlist_track = PlaylistTrack.new(playlist_track_params)

    if @playlist_track.save
      render json: @playlist_track, status: :created, location: @playlist_track
    else
      render json: @playlist_track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /playlist_tracks/1
  def update
    if @playlist_track.update(playlist_track_params)
      render json: @playlist_track
    else
      render json: @playlist_track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlist_tracks/1
  def destroy
    @playlist_track.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_track
      @playlist_track = PlaylistTrack.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def playlist_track_params
      params.require(:playlist_track).permit(:playlist_id, :track_id)
    end
end
