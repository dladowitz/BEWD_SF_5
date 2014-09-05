class MoviesController < ApplicationController
  before_action :set_movie, only: [:update, :edit, :show]

  def index
    @movies = Movie.search_for(params[:q])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      redirect_to @movie, notice: "Movie was saved!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was updated!"
    else
      render 'edit'
    end
  end

  def show
  end

  private

  def set_movie
    @movie = Movie.find params[:id]
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :year_released, :rating)
  end
end
