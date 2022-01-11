class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
# above line will return the render_not_found_response as a default for ALL controller actions, when we run into the "ActiveRecord::RecordNotFound" error

  # GET /spices
  def index
    render json: Spice.all
  end

  # GET /spices/:id
  def show 
    spice = Spice.find_by(id: params[:id])
    if spice
      render json: spice
    else
      render json: { error: "Spice not found" }, status: :not_found
    end
  end

  # POST /spices
  def create 
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  # PATCH /spices/:id
  def update
    spice = Spice.find_by(id: params[:id])
    spice.update(spice_params)
    render json: spice
  end

  # DELETE /spices/:id
  def destroy 
    spice = Spice.find_by(id: params[:id])
    spice.destroy
    head :no_content
  end


  private

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

end
