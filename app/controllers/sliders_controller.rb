class SlidersController < ApplicationController
  before_action :find_slider, only: [:show, :edit, :update, :destroy]
  layout "application"
  def index
    @slider = Slider.find(2)
  end

  def show
  end

  def new
    @slider = Slider.new
    6.times { @slider.slider_images.build }
  end

  def create 
    @slider = Slider.new(slider_params)

    if @slider.save
      redirect_to @slider, notice: "Uspesno kreiran Slider!"
    else
      render 'new'
    end
  end

  def update
    if @slider.update(slider_params)
      redirect_to @slider, notice: "Uspesno editovan Slider"
    else
      render 'edit'
    end
  end

  def edit
    6.times { @slider.slider_images.build }
  end

  def destroy
    @slider.destroy
    redirect_to sliders_path, notice: "Slider Uspesno Obrisan!"
  end

  private

  def slider_params
    params.require(:slider).permit( :slider_id, :slider_name, slider_images_attributes: [ :id, :image, :_destroy ] )
  end 

  def find_slider
    @slider = Slider.find(params[:id])
  end

end
