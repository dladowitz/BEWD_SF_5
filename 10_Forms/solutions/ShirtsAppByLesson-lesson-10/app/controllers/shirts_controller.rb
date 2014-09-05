class ShirtsController < ApplicationController
  before_action :set_shirt, only: [:edit, :show, :update]

  def index
    @shirts = Shirt.search_for(params[:q])
  end

  def new
    @shirt = Shirt.new
  end

  def create
    @shirt = Shirt.new(shirt_params)
    if @shirt.save
      redirect_to @shirt, notice: "Shirt was created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @shirt.update shirt_params
      redirect_to @shirt, notice: "Shirt was updated!"
    else
      render 'edit'
    end
  end

  def show
  end

  private

  def set_shirt
    @shirt = Shirt.find(params[:id])
  end

  def shirt_params
    params.require('shirt').permit(:name, :description, :image)
  end
end
