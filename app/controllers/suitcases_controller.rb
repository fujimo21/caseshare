class SuitcasesController < ApplicationController
  before_action :set_suitcase, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  
  def index
    @suitcases = current_user.suitcases
  end

  def show
    @photos = @suitcase.photos
    
    @booked = Reservation.where("suitcase_id = ? AND user_id = ?", @suitcase.id, current_user.id).present? if current_user
    
    @reviews = @suitcase.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @suitcase = current_user.suitcases.build
  end

  def create
    @suitcase = current_user.suitcases.build(suitcase_params)

    if @suitcase.save
      
      if params[:images]
        params[:images].each do |image|
          @suitcase.photos.create(image: image)
        end
      end
      
      @photos = @suitcase.photos
      redirect_to edit_suitcase_path(@suitcase), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @suitcase.user.id
      @photos = @suitcase.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @suitcase.update(suitcase_params)
      
      if params[:images]
        params[:images].each do |image|
          @suitcase.photos.create(image: image)
        end
      end
      
      redirect_to edit_suitcase_path(@suitcase), notice: "Updated..."
    else
      render :edit
    end
  end
  
  def destroy
    @suitcase.destroy
    redirect_to suitcases_path, notice: "Deleted..."
  end

  
  private
    def set_suitcase
      @suitcase = Suitcase.find(params[:id])
    end
    
    def suitcase_params
      params.require(:suitcase).permit(:case_type, :case_size, :has_key, :listing_name,:summary, :price, :active)
    end
end
