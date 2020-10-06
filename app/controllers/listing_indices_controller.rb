class ListingIndicesController < ApplicationController
  before_action :set_listing_index, only: [:show, :edit, :update, :destroy]

  # GET /listing_indices
  def index
    @listing_indices = ListingIndex.all
  end

  # GET /listing_indices/1
  def show
  end

  # GET /listing_indices/new
  def new
    @listing_index = ListingIndex.new
  end

  # GET /listing_indices/1/edit
  def edit
  end

  # POST /listing_indices
  def create
    @listing_index = ListingIndex.new(listing_index_params)

    if @listing_index.save
      redirect_to @listing_index, notice: 'Listing index was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /listing_indices/1
  def update
    if @listing_index.update(listing_index_params)
      redirect_to @listing_index, notice: 'Listing index was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listing_indices/1
  def destroy
    @listing_index.destroy
    redirect_to listing_indices_url, notice: 'Listing index was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing_index
      @listing_index = ListingIndex.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def listing_index_params
      params.require(:listing_index).permit(:source_document)
    end
end
