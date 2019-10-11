class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.movie_ratings
    if params[:ratings].nil?
      @ratings = @all_ratings
    else
      @ratings = params[:ratings].keys
    end
    if params[:sort] == "title"
      @movies = Movie.with_ratings(@ratings).sort_by { |a| [ a.title] }
      @highlight = 'title'
    elsif params[:sort] == "release_date"
      @movies = Movie.with_ratings(@ratings).sort_by { |a| [ a.release_date] }
      @highlight = 'release_date'
    else
      @movies = Movie.with_ratings(@ratings)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
