class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  #default setting is sort by id and select all checkbox
 
 def index
  
  @all_ratings = Movie.all_ratings.keys

  if params[:sort].nil? || params[:ratings].nil? 
    sort_param = params[:sort] || session[:sort] || :id
    ratings_param = params[:ratings] || session[:ratings] || Movie.all_ratings
    flash.keep
    redirect_to movies_path(sort: sort_param, ratings: ratings_param) 
  else
    @sort = session[:sort] = params[:sort]
    @ratings = session[:ratings] = params[:ratings]
    @movies = Movie.all.where(rating: @ratings.keys).order(@sort)
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
