class SuitcasesController < ApplicationController
  before_action :set_room, only: [:shoe, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  
  def index
    @suitcases = current_user.suitcases
  end

  def show
    @suitcases = Suitcase.find(params[:id])
  end

  def new
    @suitcase = current_user.suitcases.build
  end

  def create
    @suitcases = current_user.suitcases.build(suitcase_params)

    if @suitcases.save 
      redirect_to @suitcases, notice: "Saved..."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suitcases.update(suitcase_params)
      redirect_to @suitcases, notice: "Updated..."
    else
      render :edit
    end
  end
  
  private
    def set_room
      @suitcases = Suitcase.find(params[:id])
    end
    
    def suitcase_params
      params.require(:suitcase).permit(:case_type, :case_size, :has_key, :summary, :price, :active)
    end
end
