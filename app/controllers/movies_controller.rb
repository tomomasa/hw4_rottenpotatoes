class MoviesController < ApplicationController

  def show
<<<<<<< HEAD
=======
    session[:back] = true
>>>>>>> heroku/master
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
<<<<<<< HEAD
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    if params[:sort] != session[:sort]
      session[:sort] = sort
      @session_sort = session[:sort]  
      redirect_to :sort => sort, :ratings => @selected_ratings, :director => director and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
       @session_sort = session[:sort]  
       @session_ratings = session[:ratings]  
      redirect_to :sort => sort, :ratings => @selected_ratings, :director => director and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end
=======
    if params[:sort]
      @sort= params[:sort]
      session[:sort] = @sort
    elsif session[:sort]
      @sort = session[:sort]
    end
    @all_ratings = Movie.get_all_ratings
    @where_statement = ""
    @not_first = params[:not_first]
    if session[:not_first]
      @not_first = session[:not_first]
    end
    if params[:ratings]
      @checked_ratings = params[:ratings]
      session[:checked_ratings] = @checked_ratings
    elsif !@not_first
      @not_first = true
      session[:not_first] = true
      @checked_ratings = {'G'=>1, 'PG'=>1, 'PG-13'=>1, 'R'=>1}
      session[:checked_ratings] = @checked_ratings
    elsif session[:back] && !params[:index] && session[:checked_ratings]
      @checked_ratings = session[:checked_ratings]
    elsif !session[:back] && !params[:index] && session[:checked_ratings]
      @checked_ratings = session[:checked_ratings]
    else
      @checked_ratings = nil
      session[:checked_ratings] = nil
    end
    where_maker
    session[:back] = false
    @movies = Movie.where(@where_statement).order(@sort).all
    end
>>>>>>> heroku/master

  def new
    # default: render 'new' template
  end

<<<<<<< HEAD
  def create
    @m = params[:movie]
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @i = params[:id]
=======
  def where_maker
    if @checked_ratings
      @checked_ratings.keys.each do |rate|
        @where_statement += "rating = '#{rate}' or "
      end
      @where_statement = @where_statement.chop().chop().chop()
    else
      @where_statement = "rating = 'NONE EXISTENT'"
    end
  end

  def create
    session[:back] = true
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path ({:sort => session[:sort], :checked_ratings => session[:checked_ratings]})
  end

  def edit
    session[:back] = true
>>>>>>> heroku/master
    @movie = Movie.find params[:id]
  end

  def update
<<<<<<< HEAD
=======
    session[:back] = true
>>>>>>> heroku/master
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
<<<<<<< HEAD
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def director
    if (params[:id] == nil) 
      return
    end
    @id = params[:id]
    @director = Movie.find(@id).director
    if (@director != nil && @director != "")
      @d = @director
      @movies = Movie.find_by_director(@director)
    else
      @title = Movie.find(@id).title
      flash[:warning] = "'" + @title + "' has no director info"
      redirect_to movies_path
    end
  end
  
=======
    session[:back] = true
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path ({:sort => session[:sort], :checked_ratings => session[:checked_ratings]})
  end

>>>>>>> heroku/master
end
