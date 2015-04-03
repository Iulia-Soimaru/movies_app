require 'json'
require 'omdb'
require 'httparty'

get '/' do
  erb :main
end


get '/logout' do
  logout!
  redirect '/'
end


##############################################################


post '/signup' do
  user = User.new(full_name: params[:full_name], email: params[:email], password: params[:password])
  if user.save
    status 200
    login_as_user(user)
    redirect "profile/#{user.id}"
  else
    status 404
    "Sorry mistake happened during sign up"
  end
end


put '/signin' do
  user = User.where(email: params[:email]).first
  if user && user.password == params[:password]
    login_as_user(user)
    status 200
    redirect "/profile/#{user.id}"
  else
    status 404
    "Sorry error happened during sign in"
  end
end

##############################################################

get '/profile/:user_id' do
  @user = User.find(params[:user_id])
  # @another_user = User.find(params[:user_id])
  erb :profile
end

get '/profile/:user_id/movie_list' do
  @user = User.find(params[:user_id])
  # p @user
  # p session[:user_id]
  erb :movie_list
end

##############################################################

post '/profile/:user_id' do
  @user = User.find(session[:user_id])
  p @user
  @title = params[:title]
  p @title
  p params
  @movie = HTTParty.get("http://www.omdbapi.com/?t=#{URI.escape(@title)}")
  if Movie.where(title: @movie["Title"]).first
    p "Movie already exists"
    @movie = Movie.where(title: @movie["Title"]).first
    unless @user.movies.include?(@movie)
      @user.movies << @movie
    end
  else
    @movie = @user.movies.create(title: @movie["Title"], year: @movie["Year"], runtime: @movie["Runtime"], genre: @movie["Genre"], director: @movie["Director"], writer: @movie["Writer"], actors: @movie["Actors"], plot: @movie["Plot"], language: @movie["Language"], country: @movie["Country"], awards: @movie["Awards"], imdbRating: @movie["imdbRating"], poster: @movie["Poster"])
    p @movie
  end
  content_type :json
  @movie.to_json
end


post '/:movie_id/rating' do
  # binding.pry
  p @person = User.find(session[:user_id])
  p
  if Rating.exists?(user_id: @person.id, movie_id: params[:movie_id])
    status 404
    p "This movie has been already rated"
  else
    content_type :json
    status 200
    @rating = Rating.create(user_id: @person.id, movie_id: params[:movie_id], rate_value: params[:rate_value])
  end
    content_type :json
    @rating.to_json
end

post '/:movie_id/comment' do
  @user = User.find(session[:user_id])
  @movie = Movie.find(params[:movie_id])
end




############################################################################

get '/search' do
  @user = User.where(full_name: params[:name]).first
  if !@user
    status 404
    p "User was not found, sorry"
  else
    redirect "/profile/#{@user.id}"
  end
end



post '/profile/:user_id/add' do
  @current_user = User.find(session[:user_id])
  @user = User.find(params[:user_id])
  @current_user.preys << @user
  content_type :json
  {person_name: @user.full_name }.to_json
end







